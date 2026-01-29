import subprocess
import pandas as pd
from datetime import datetime
import json
import os
import io

# === CONFIGURATION ===
ACCESS_PATH = "/home/bomar-ubu-1/migration-access/risk.mdb"  # WSL path to your .mdb file
OUTPUT_DIR = "access_analysis"


class AccessDatabaseAnalyzerWSL:
    def __init__(self, db_path):
        self.db_path = db_path
        self.report = {}
        
        # Verify mdbtools is installed
        try:
            subprocess.run(["mdb-tables", "--version"], capture_output=True, check=True)
        except FileNotFoundError:
            raise RuntimeError("mdbtools not installed. Run: sudo apt install mdbtools")
        
        # Verify file exists
        if not os.path.exists(db_path):
            raise FileNotFoundError(f"Database not found: {db_path}")
    
    def run_mdb_command(self, command, *args):
        """Run an mdbtools command and return output"""
        try:
            result = subprocess.run(
                [command, self.db_path, *args],
                capture_output=True,
                text=True,
                check=True
            )
            return result.stdout
        except subprocess.CalledProcessError as e:
            print(f"   Warning: {command} failed - {e.stderr}")
            return ""
    
    def analyze_all(self):
        """Run complete database analysis"""
        print("=" * 60)
        print("ACCESS DATABASE ANALYZER (WSL/Linux)")
        print("=" * 60)
        print(f"Database: {self.db_path}")
        print(f"Analysis started: {datetime.now()}\n")
        
        self.report["database_path"] = self.db_path
        self.report["analysis_date"] = str(datetime.now())
        
        self.get_tables()
        self.get_queries()
        self.get_relationships()
        self.analyze_table_details()
        self.analyze_data_quality()
        self.identify_potential_issues()
        
        return self.report
    
    def get_tables(self):
        """Get all user tables"""
        print("Analyzing tables...")
        
        output = self.run_mdb_command("mdb-tables", "-1")
        tables = [t.strip() for t in output.strip().split("\n") if t.strip()]
        
        # Filter out system tables
        tables = [t for t in tables if not t.startswith("MSys")]
        
        self.report["tables"] = {
            "count": len(tables),
            "names": tables
        }
        print(f"   Found {len(tables)} tables\n")
        return tables
    
    def get_queries(self):
        """Get saved queries using mdb-queries"""
        print("Analyzing saved queries...")
        
        queries = []
        
        try:
            output = self.run_mdb_command("mdb-queries", "-L")
            if output.strip():
                for line in output.strip().split("\n"):
                    if line.strip():
                        queries.append({
                            "name": line.strip(),
                            "type": "QUERY",
                            "sql": None
                        })
                
                # Try to get SQL for each query
                for q in queries:
                    try:
                        sql_output = self.run_mdb_command("mdb-queries", q["name"])
                        q["sql"] = sql_output.strip()[:500]  # Limit length
                    except:
                        pass
        except Exception as e:
            print(f"   Warning: Could not read queries - {e}")
        
        self.report["queries"] = {
            "count": len(queries),
            "details": queries
        }
        print(f"   Found {len(queries)} saved queries\n")
        
        if queries:
            print("   WARNING: Review these queries - they may need recreation in PostgreSQL\n")
        
        return queries
    
    def get_relationships(self):
        """Get relationships using mdb-schema"""
        print("Analyzing relationships...")
        
        relationships = []
        
        try:
            # Get schema which includes relationship info
            output = self.run_mdb_command("mdb-schema", "--relationships")
            
            # Parse ALTER TABLE ... ADD CONSTRAINT ... FOREIGN KEY statements
            for line in output.split("\n"):
                if "FOREIGN KEY" in line.upper() and "REFERENCES" in line.upper():
                    # Basic parsing - may need refinement
                    relationships.append({
                        "definition": line.strip(),
                        "parsed": False
                    })
        except Exception as e:
            print(f"   Warning: Could not read relationships - {e}")
        
        self.report["relationships"] = {
            "count": len(relationships),
            "details": relationships
        }
        print(f"   Found {len(relationships)} relationships\n")
        return relationships
    
    def get_table_schema(self, table_name):
        """Get column info for a table using mdb-schema"""
        columns = []
        
        try:
            output = self.run_mdb_command("mdb-schema", "-T", table_name)
            
            # Parse CREATE TABLE statement
            in_create = False
            for line in output.split("\n"):
                line = line.strip()
                
                if line.upper().startswith("CREATE TABLE"):
                    in_create = True
                    continue
                
                if in_create and line.startswith(")"):
                    break
                
                if in_create and line and not line.startswith("("):
                    # Parse column definition
                    # Format: column_name TYPE(size) [NOT NULL]
                    parts = line.rstrip(",").split()
                    if parts:
                        col_name = parts[0].strip("[]\"")
                        col_type = parts[1] if len(parts) > 1 else "VARCHAR"
                        
                        # Extract size if present
                        size = None
                        if "(" in col_type:
                            type_parts = col_type.split("(")
                            col_type = type_parts[0]
                            size = type_parts[1].rstrip(")")
                            try:
                                size = int(size.split(",")[0])
                            except:
                                size = None
                        
                        nullable = "NOT NULL" not in line.upper()
                        
                        columns.append({
                            "name": col_name,
                            "pg_name": col_name.lower().replace(" ", "_").replace("-", "_"),
                            "type": col_type.upper(),
                            "size": size,
                            "decimal_digits": None,
                            "nullable": nullable,
                            "ordinal": len(columns) + 1
                        })
        except Exception as e:
            print(f"      Error getting schema: {e}")
        
        return columns
    
    def export_table_to_df(self, table_name):
        """Export a table to pandas DataFrame"""
        try:
            output = self.run_mdb_command("mdb-export", table_name)
            if output:
                return pd.read_csv(io.StringIO(output))
        except Exception as e:
            print(f"      Error exporting {table_name}: {e}")
        return pd.DataFrame()
    
    def analyze_table_details(self):
        """Detailed analysis of each table"""
        print("Analyzing table structures...")
        
        table_details = []
        
        for table in self.report["tables"]["names"]:
            print(f"   Processing: {table}")
            
            detail = {
                "name": table,
                "pg_name": table.lower().replace(" ", "_").replace("-", "_"),
                "columns": [],
                "row_count": 0,
                "primary_key": None
            }
            
            # Get columns
            detail["columns"] = self.get_table_schema(table)
            
            # Get row count by exporting and counting
            try:
                df = self.export_table_to_df(table)
                detail["row_count"] = len(df)
            except:
                detail["row_count"] = 0
            
            table_details.append(detail)
        
        self.report["table_details"] = table_details
        print()
        return table_details
    
    def analyze_data_quality(self):
        """Analyze data quality"""
        print("Analyzing data quality (this may take a while)...")
        
        quality_report = []
        
        for table in self.report["table_details"]:
            table_name = table["name"]
            print(f"   Profiling: {table_name}")
            
            table_quality = {
                "table": table_name,
                "columns": []
            }
            
            try:
                df = self.export_table_to_df(table_name)
                
                for col in table["columns"]:
                    col_name = col["name"]
                    col_quality = {
                        "column": col_name,
                        "null_count": 0,
                        "null_percent": 0,
                        "distinct_count": 0,
                        "sample_values": []
                    }
                    
                    if col_name in df.columns:
                        col_quality["null_count"] = int(df[col_name].isna().sum())
                        if len(df) > 0:
                            col_quality["null_percent"] = round(
                                (col_quality["null_count"] / len(df)) * 100, 2
                            )
                        col_quality["distinct_count"] = int(df[col_name].nunique())
                        col_quality["sample_values"] = [
                            str(v)[:50] for v in df[col_name].dropna().unique()[:5]
                        ]
                    
                    table_quality["columns"].append(col_quality)
            except Exception as e:
                print(f"      Error profiling: {e}")
            
            quality_report.append(table_quality)
        
        self.report["data_quality"] = quality_report
        print()
        return quality_report
    
    def identify_potential_issues(self):
        """Identify potential migration issues"""
        print("Identifying potential migration issues...")
        
        issues = []
        pg_reserved = ['user', 'order', 'table', 'group', 'select', 'where', 'index', 
                       'key', 'primary', 'foreign', 'check', 'default', 'constraint']
        
        for table in self.report["table_details"]:
            table_name = table["name"]
            pg_name = table["pg_name"]
            
            if table_name != pg_name:
                issues.append({
                    "type": "NAMING",
                    "severity": "MEDIUM",
                    "table": table_name,
                    "column": None,
                    "issue": f"Table name will change: '{table_name}' -> '{pg_name}'",
                    "action": "Update Power BI queries to use new name"
                })
            
            if pg_name.lower() in pg_reserved:
                issues.append({
                    "type": "RESERVED_WORD",
                    "severity": "HIGH",
                    "table": table_name,
                    "column": None,
                    "issue": f"'{pg_name}' is a PostgreSQL reserved word",
                    "action": "Rename table or use quoted identifiers"
                })
            
            for col in table["columns"]:
                col_name = col["name"]
                pg_col_name = col["pg_name"]
                
                if col_name != pg_col_name:
                    issues.append({
                        "type": "NAMING",
                        "severity": "MEDIUM",
                        "table": table_name,
                        "column": col_name,
                        "issue": f"Column name will change: '{col_name}' -> '{pg_col_name}'",
                        "action": "Update Power BI queries"
                    })
                
                if pg_col_name.lower() in pg_reserved:
                    issues.append({
                        "type": "RESERVED_WORD",
                        "severity": "HIGH",
                        "table": table_name,
                        "column": col_name,
                        "issue": f"'{pg_col_name}' is a PostgreSQL reserved word",
                        "action": "Rename column or use quoted identifiers"
                    })
                
                if col["type"] in ["LONGBINARY", "OLE"]:
                    issues.append({
                        "type": "DATA_TYPE",
                        "severity": "HIGH",
                        "table": table_name,
                        "column": col_name,
                        "issue": "OLE Object field - may contain embedded files/images",
                        "action": "Decide how to handle binary data"
                    })
            
            if not table.get("primary_key"):
                issues.append({
                    "type": "SCHEMA",
                    "severity": "MEDIUM",
                    "table": table_name,
                    "column": None,
                    "issue": "No primary key defined",
                    "action": "Consider adding a primary key in PostgreSQL"
                })
        
        if self.report["queries"]["count"] > 0:
            issues.append({
                "type": "QUERIES",
                "severity": "HIGH",
                "table": None,
                "column": None,
                "issue": f"{self.report['queries']['count']} saved queries found",
                "action": "Review and recreate as PostgreSQL views or Power BI queries"
            })
        
        self.report["potential_issues"] = {
            "count": len(issues),
            "by_severity": {
                "HIGH": len([i for i in issues if i["severity"] == "HIGH"]),
                "MEDIUM": len([i for i in issues if i["severity"] == "MEDIUM"]),
                "LOW": len([i for i in issues if i["severity"] == "LOW"])
            },
            "details": issues
        }
        
        print(f"   Found {len(issues)} potential issues")
        print(f"   - HIGH: {self.report['potential_issues']['by_severity']['HIGH']}")
        print(f"   - MEDIUM: {self.report['potential_issues']['by_severity']['MEDIUM']}")
        print(f"   - LOW: {self.report['potential_issues']['by_severity']['LOW']}\n")
        
        return issues
    
    def export_reports(self, output_dir):
        """Export all reports to files"""
        print("Exporting reports...")
        
        os.makedirs(output_dir, exist_ok=True)
        
        # 1. Full JSON report
        with open(f"{output_dir}/full_analysis.json", "w", encoding="utf-8") as f:
            json.dump(self.report, f, indent=2, default=str, ensure_ascii=False)
        print(f"   Saved: {output_dir}/full_analysis.json")
        
        # 2. Table summary Excel
        table_summary = []
        for t in self.report["table_details"]:
            table_summary.append({
                "access_name": t["name"],
                "postgresql_name": t["pg_name"],
                "columns": len(t["columns"]),
                "rows": t["row_count"],
                "primary_key": t.get("primary_key") or "NONE",
                "name_changed": t["name"] != t["pg_name"]
            })
        pd.DataFrame(table_summary).to_excel(f"{output_dir}/tables_summary.xlsx", index=False)
        print(f"   Saved: {output_dir}/tables_summary.xlsx")
        
        # 3. Columns detail Excel
        columns_detail = []
        for t in self.report["table_details"]:
            for c in t["columns"]:
                columns_detail.append({
                    "table": t["name"],
                    "column": c["name"],
                    "pg_column": c["pg_name"],
                    "type": c["type"],
                    "size": c["size"],
                    "nullable": c["nullable"],
                    "name_changed": c["name"] != c["pg_name"]
                })
        pd.DataFrame(columns_detail).to_excel(f"{output_dir}/columns_detail.xlsx", index=False)
        print(f"   Saved: {output_dir}/columns_detail.xlsx")
        
        # 4. Relationships
        if self.report["relationships"]["details"]:
            pd.DataFrame(self.report["relationships"]["details"]).to_excel(
                f"{output_dir}/relationships.xlsx", index=False
            )
            print(f"   Saved: {output_dir}/relationships.xlsx")
        
        # 5. Issues Excel
        if self.report["potential_issues"]["details"]:
            pd.DataFrame(self.report["potential_issues"]["details"]).to_excel(
                f"{output_dir}/issues.xlsx", index=False
            )
            print(f"   Saved: {output_dir}/issues.xlsx")
        
        # 6. Queries list
        if self.report["queries"]["details"]:
            pd.DataFrame(self.report["queries"]["details"]).to_excel(
                f"{output_dir}/queries.xlsx", index=False
            )
            print(f"   Saved: {output_dir}/queries.xlsx")
        
        # 7. Data quality Excel
        quality_rows = []
        for tq in self.report["data_quality"]:
            for cq in tq["columns"]:
                quality_rows.append({
                    "table": tq["table"],
                    "column": cq["column"],
                    "null_count": cq.get("null_count"),
                    "null_percent": cq.get("null_percent"),
                    "distinct_count": cq.get("distinct_count"),
                    "sample_values": "; ".join(str(v) for v in cq.get("sample_values", []))
                })
        pd.DataFrame(quality_rows).to_excel(f"{output_dir}/data_quality.xlsx", index=False)
        print(f"   Saved: {output_dir}/data_quality.xlsx")
        
        # 8. PostgreSQL schema
        self.generate_pg_schema(f"{output_dir}/postgresql_schema.sql")
        print(f"   Saved: {output_dir}/postgresql_schema.sql")
        
        # 9. Summary
        self.generate_summary(f"{output_dir}/MIGRATION_SUMMARY.md")
        print(f"   Saved: {output_dir}/MIGRATION_SUMMARY.md")

        # 10. Migration Review Checklist (for stakeholders)
        self.generate_migration_review_checklist(f"{output_dir}/migration_review_checklist.xlsx")
        print(f"   Saved: {output_dir}/migration_review_checklist.xlsx")

        print(f"\nAll reports exported to '{output_dir}/' folder")
    
    def generate_pg_schema(self, filepath):
        """Generate PostgreSQL schema - can also use mdb-schema directly"""
        type_map = {
            "COUNTER": "SERIAL",
            "LONG INTEGER": "INTEGER",
            "INTEGER": "INTEGER",
            "SMALLINT": "SMALLINT",
            "SINGLE": "REAL",
            "DOUBLE": "DOUBLE PRECISION",
            "CURRENCY": "NUMERIC(19,4)",
            "DATETIME": "TIMESTAMP",
            "BOOLEAN": "BOOLEAN",
            "TEXT": "TEXT",
            "MEMO": "TEXT",
            "VARCHAR": "VARCHAR",
            "LONGBINARY": "BYTEA",
            "OLE": "BYTEA",
            "BYTE": "SMALLINT",
        }
        
        with open(filepath, "w", encoding="utf-8") as f:
            f.write("-- PostgreSQL Schema Generated from Access Database\n")
            f.write(f"-- Generated: {datetime.now()}\n")
            f.write(f"-- Source: {self.db_path}\n\n")
            
            # Option 1: Use mdb-schema directly for PostgreSQL
            f.write("-- Auto-generated using mdb-schema:\n")
            try:
                schema = self.run_mdb_command("mdb-schema", "--postgres")
                f.write(schema)
            except:
                # Option 2: Manual generation
                for table in self.report["table_details"]:
                    f.write(f"\n-- Table: {table['name']}\n")
                    f.write(f'CREATE TABLE "{table["pg_name"]}" (\n')
                    
                    col_lines = []
                    for col in table["columns"]:
                        pg_type = type_map.get(col["type"].upper(), "TEXT")
                        if pg_type == "VARCHAR" and col["size"]:
                            pg_type = f"VARCHAR({col['size']})"
                        
                        nullable = "" if col["nullable"] else " NOT NULL"
                        col_lines.append(f'    "{col["pg_name"]}" {pg_type}{nullable}')
                    
                    f.write(",\n".join(col_lines))
                    f.write("\n);\n")
    
    def generate_migration_review_checklist(self, filepath):
        """Generate comprehensive migration review checklist for stakeholders"""
        print("   Generating migration review checklist...")

        from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
        from openpyxl.utils import get_column_letter
        from openpyxl.worksheet.datavalidation import DataValidation

        # Create Excel writer
        with pd.ExcelWriter(filepath, engine='openpyxl') as writer:

            # Sheet 1: Tables Review
            tables_review = []
            for table in self.report["table_details"]:
                # Count issues for this table
                table_issues = [i for i in self.report["potential_issues"]["details"]
                               if i.get("table") == table["name"]]

                # Detect potential deprecated tables
                is_deprecated = (
                    table["name"].lower().startswith("xxx") or
                    "paste error" in table["name"].lower() or
                    "copy of" in table["name"].lower() or
                    table["row_count"] == 0
                )

                # Estimate usage based on row count and name
                estimated_status = "UNKNOWN"
                if is_deprecated:
                    estimated_status = "DEPRECATED"
                elif table["row_count"] > 0:
                    estimated_status = "ACTIVE"
                else:
                    estimated_status = "EMPTY"

                # Suggest priority based on row count and issues
                suggested_priority = "MEDIUM"
                if table["row_count"] > 100:
                    suggested_priority = "HIGH"
                elif table["row_count"] > 20:
                    suggested_priority = "MEDIUM"
                else:
                    suggested_priority = "LOW"

                tables_review.append({
                    "Table_Name_Access": table["name"],
                    "Table_Name_PostgreSQL": table["pg_name"],
                    "Row_Count": table["row_count"],
                    "Column_Count": len(table["columns"]),
                    "Name_Will_Change": "YES" if table["name"] != table["pg_name"] else "NO",
                    "Estimated_Status": estimated_status,
                    "Suggested_Priority": suggested_priority,
                    "Issues_Count": len(table_issues),
                    "DECISION_Keep_or_Discard": "",  # Empty for user to fill
                    "DECISION_Final_Priority": "",  # Empty for user to fill
                    "DECISION_Notes": "",  # Empty for user to fill
                    "Used_in_PowerBI": ""  # Empty for user to fill
                })

            df_tables = pd.DataFrame(tables_review)
            df_tables.to_excel(writer, sheet_name='Tables_Review', index=False)

            # Sheet 2: Columns Review
            columns_review = []
            for table in self.report["table_details"]:
                for col in table["columns"]:
                    # Get quality info if available
                    quality_info = None
                    for tq in self.report.get("data_quality", []):
                        if tq["table"] == table["name"]:
                            for cq in tq["columns"]:
                                if cq["column"] == col["name"]:
                                    quality_info = cq
                                    break

                    # Detect potential issues
                    has_special_chars = any(c in col["name"] for c in [" ", "(", ")", "/", "%", "-"])

                    suggested_action = "KEEP"
                    if col["name"].lower().startswith("f") and col["name"][1:].isdigit():
                        # Generic column names like F1, F2, F10
                        suggested_action = "REVIEW"

                    columns_review.append({
                        "Table_Name": table["name"],
                        "Column_Name_Access": col["name"],
                        "Column_Name_PostgreSQL": col["pg_name"],
                        "Data_Type": col["type"],
                        "Size": col.get("size", ""),
                        "Nullable": "YES" if col["nullable"] else "NO",
                        "Name_Will_Change": "YES" if col["name"] != col["pg_name"] else "NO",
                        "Has_Special_Characters": "YES" if has_special_chars else "NO",
                        "Null_Percent": quality_info.get("null_percent", "") if quality_info else "",
                        "Distinct_Count": quality_info.get("distinct_count", "") if quality_info else "",
                        "Sample_Values": "; ".join(str(v)[:30] for v in quality_info.get("sample_values", [])[:3]) if quality_info else "",
                        "Suggested_Action": suggested_action,
                        "DECISION_Keep_or_Discard": "",  # Empty for user to fill
                        "DECISION_Notes": ""  # Empty for user to fill
                    })

            df_columns = pd.DataFrame(columns_review)
            df_columns.to_excel(writer, sheet_name='Columns_Review', index=False)

            # Sheet 3: Summary Dashboard
            summary_data = []

            # Table statistics
            total_tables = len(self.report["table_details"])
            deprecated_tables = sum(1 for t in tables_review if t["Estimated_Status"] == "DEPRECATED")
            active_tables = sum(1 for t in tables_review if t["Estimated_Status"] == "ACTIVE")
            empty_tables = sum(1 for t in tables_review if t["Estimated_Status"] == "EMPTY")

            summary_data.append({"Metric": "Total Tables", "Count": total_tables})
            summary_data.append({"Metric": "- Active Tables", "Count": active_tables})
            summary_data.append({"Metric": "- Deprecated/Test Tables", "Count": deprecated_tables})
            summary_data.append({"Metric": "- Empty Tables", "Count": empty_tables})
            summary_data.append({"Metric": "", "Count": ""})

            # Column statistics
            total_columns = sum(len(t["columns"]) for t in self.report["table_details"])
            columns_with_name_changes = sum(1 for c in columns_review if c["Name_Will_Change"] == "YES")
            columns_with_special_chars = sum(1 for c in columns_review if c["Has_Special_Characters"] == "YES")

            summary_data.append({"Metric": "Total Columns", "Count": total_columns})
            summary_data.append({"Metric": "- Columns with Name Changes", "Count": columns_with_name_changes})
            summary_data.append({"Metric": "- Columns with Special Characters", "Count": columns_with_special_chars})
            summary_data.append({"Metric": "", "Count": ""})

            # Data statistics
            total_rows = sum(t["row_count"] for t in self.report["table_details"] if isinstance(t["row_count"], int))
            summary_data.append({"Metric": "Total Data Rows", "Count": total_rows})
            summary_data.append({"Metric": "", "Count": ""})

            # Issues
            summary_data.append({"Metric": "Total Issues Identified", "Count": self.report["potential_issues"]["count"]})
            summary_data.append({"Metric": "- HIGH Severity", "Count": self.report["potential_issues"]["by_severity"]["HIGH"]})
            summary_data.append({"Metric": "- MEDIUM Severity", "Count": self.report["potential_issues"]["by_severity"]["MEDIUM"]})
            summary_data.append({"Metric": "- LOW Severity", "Count": self.report["potential_issues"]["by_severity"]["LOW"]})

            df_summary = pd.DataFrame(summary_data)
            df_summary.to_excel(writer, sheet_name='Summary_Dashboard', index=False)

            # Sheet 4: Instructions
            instructions = [
                {"Section": "PURPOSE", "Instructions": "This checklist helps you review all database objects before migration"},
                {"Section": "", "Instructions": ""},
                {"Section": "HOW TO USE", "Instructions": ""},
                {"Section": "1. Tables Review", "Instructions": "Review each table and fill in the DECISION columns:"},
                {"Section": "", "Instructions": "  - DECISION_Keep_or_Discard: Enter KEEP, DISCARD, or REVIEW"},
                {"Section": "", "Instructions": "  - DECISION_Final_Priority: Enter CRITICAL, HIGH, MEDIUM, or LOW"},
                {"Section": "", "Instructions": "  - DECISION_Notes: Add any comments or reasons"},
                {"Section": "", "Instructions": "  - Used_in_PowerBI: Enter YES or NO if you know"},
                {"Section": "", "Instructions": ""},
                {"Section": "2. Columns Review", "Instructions": "Review columns for tables you're keeping:"},
                {"Section": "", "Instructions": "  - DECISION_Keep_or_Discard: Enter KEEP or DISCARD"},
                {"Section": "", "Instructions": "  - DECISION_Notes: Note why you're discarding (if applicable)"},
                {"Section": "", "Instructions": ""},
                {"Section": "3. Look for", "Instructions": ""},
                {"Section": "", "Instructions": "  - Tables with 'xxx' prefix (usually test/deprecated)"},
                {"Section": "", "Instructions": "  - Tables with 0 rows (may be obsolete)"},
                {"Section": "", "Instructions": "  - 'Copy Of' or 'Paste Error' tables (backups/errors)"},
                {"Section": "", "Instructions": "  - Columns with generic names (F1, F2, F10)"},
                {"Section": "", "Instructions": "  - Columns that are always empty (high null %)"},
                {"Section": "", "Instructions": ""},
                {"Section": "4. Save", "Instructions": "Save this file and share with migration team"},
                {"Section": "", "Instructions": ""},
                {"Section": "SUGGESTED PRIORITIES", "Instructions": ""},
                {"Section": "", "Instructions": "  - CRITICAL: Core business data, used in production reports"},
                {"Section": "", "Instructions": "  - HIGH: Important data, used regularly"},
                {"Section": "", "Instructions": "  - MEDIUM: Reference data, used occasionally"},
                {"Section": "", "Instructions": "  - LOW: Archive data, rarely used"},
                {"Section": "", "Instructions": ""},
                {"Section": "QUESTIONS?", "Instructions": "Contact your migration team lead"}
            ]

            df_instructions = pd.DataFrame(instructions)
            df_instructions.to_excel(writer, sheet_name='Instructions', index=False)

            # ========================================
            # FORMATTING SECTION
            # ========================================

            # Get workbook to apply formatting
            workbook = writer.book

            # --- Format Sheet 1: Tables_Review ---
            ws_tables = workbook['Tables_Review']

            # Define styles
            header_fill = PatternFill(start_color="366092", end_color="366092", fill_type="solid")
            header_font = Font(bold=True, color="FFFFFF", size=11)
            decision_fill = PatternFill(start_color="FFF2CC", end_color="FFF2CC", fill_type="solid")
            decision_font = Font(bold=True, color="C65911", size=10)
            center_alignment = Alignment(horizontal="center", vertical="center")
            wrap_alignment = Alignment(wrap_text=True, vertical="top")

            # Format headers
            for cell in ws_tables[1]:
                cell.fill = header_fill
                cell.font = header_font
                cell.alignment = center_alignment

            # Highlight DECISION columns with yellow background
            decision_columns_tables = [9, 10, 11, 12]  # DECISION_Keep_or_Discard, DECISION_Final_Priority, DECISION_Notes, Used_in_PowerBI
            for row in range(2, ws_tables.max_row + 1):
                for col_idx in decision_columns_tables:
                    cell = ws_tables.cell(row=row, column=col_idx)
                    cell.fill = decision_fill
                    if col_idx in [9, 10, 12]:  # Not the notes column
                        cell.font = decision_font
                        cell.alignment = center_alignment

            # Set column widths
            column_widths_tables = {
                'A': 35,  # Table_Name_Access
                'B': 35,  # Table_Name_PostgreSQL
                'C': 12,  # Row_Count
                'D': 12,  # Column_Count
                'E': 15,  # Name_Will_Change
                'F': 15,  # Estimated_Status
                'G': 18,  # Suggested_Priority
                'H': 12,  # Issues_Count
                'I': 22,  # DECISION_Keep_or_Discard
                'J': 22,  # DECISION_Final_Priority
                'K': 40,  # DECISION_Notes
                'L': 18,  # Used_in_PowerBI
            }
            for col, width in column_widths_tables.items():
                ws_tables.column_dimensions[col].width = width

            # Add data validation (dropdowns) for decision columns
            # DECISION_Keep_or_Discard dropdown
            dv_keep_discard = DataValidation(type="list", formula1='"KEEP,DISCARD,REVIEW"', allow_blank=True)
            dv_keep_discard.error = 'Please select KEEP, DISCARD, or REVIEW'
            dv_keep_discard.errorTitle = 'Invalid Entry'
            ws_tables.add_data_validation(dv_keep_discard)
            dv_keep_discard.add(f'I2:I{ws_tables.max_row}')

            # DECISION_Final_Priority dropdown
            dv_priority = DataValidation(type="list", formula1='"CRITICAL,HIGH,MEDIUM,LOW"', allow_blank=True)
            dv_priority.error = 'Please select CRITICAL, HIGH, MEDIUM, or LOW'
            dv_priority.errorTitle = 'Invalid Entry'
            ws_tables.add_data_validation(dv_priority)
            dv_priority.add(f'J2:J{ws_tables.max_row}')

            # Used_in_PowerBI dropdown
            dv_powerbi = DataValidation(type="list", formula1='"YES,NO,UNKNOWN"', allow_blank=True)
            dv_powerbi.error = 'Please select YES, NO, or UNKNOWN'
            dv_powerbi.errorTitle = 'Invalid Entry'
            ws_tables.add_data_validation(dv_powerbi)
            dv_powerbi.add(f'L2:L{ws_tables.max_row}')

            # Freeze top row
            ws_tables.freeze_panes = 'A2'

            # --- Format Sheet 2: Columns_Review ---
            ws_columns = workbook['Columns_Review']

            # Format headers
            for cell in ws_columns[1]:
                cell.fill = header_fill
                cell.font = header_font
                cell.alignment = center_alignment

            # Highlight DECISION columns (columns 12 and 13)
            decision_columns_cols = [12, 13]  # DECISION_Keep_or_Discard, DECISION_Notes
            for row in range(2, ws_columns.max_row + 1):
                for col_idx in decision_columns_cols:
                    cell = ws_columns.cell(row=row, column=col_idx)
                    cell.fill = decision_fill
                    if col_idx == 12:
                        cell.font = decision_font
                        cell.alignment = center_alignment

            # Set column widths
            column_widths_cols = {
                'A': 30,  # Table_Name
                'B': 30,  # Column_Name_Access
                'C': 30,  # Column_Name_PostgreSQL
                'D': 15,  # Data_Type
                'E': 8,   # Size
                'F': 10,  # Nullable
                'G': 15,  # Name_Will_Change
                'H': 20,  # Has_Special_Characters
                'I': 12,  # Null_Percent
                'J': 12,  # Distinct_Count
                'K': 35,  # Sample_Values
                'L': 15,  # Suggested_Action
                'M': 22,  # DECISION_Keep_or_Discard
                'N': 40,  # DECISION_Notes
            }
            for col, width in column_widths_cols.items():
                ws_columns.column_dimensions[col].width = width

            # Add data validation for DECISION_Keep_or_Discard
            dv_col_decision = DataValidation(type="list", formula1='"KEEP,DISCARD,REVIEW"', allow_blank=True)
            dv_col_decision.error = 'Please select KEEP, DISCARD, or REVIEW'
            dv_col_decision.errorTitle = 'Invalid Entry'
            ws_columns.add_data_validation(dv_col_decision)
            dv_col_decision.add(f'M2:M{ws_columns.max_row}')

            # Freeze top row
            ws_columns.freeze_panes = 'A2'

            # --- Format Sheet 3: Summary_Dashboard ---
            ws_summary = workbook['Summary_Dashboard']

            # Format headers
            for cell in ws_summary[1]:
                cell.fill = header_fill
                cell.font = header_font
                cell.alignment = center_alignment

            # Bold and larger font for summary
            for row in ws_summary.iter_rows(min_row=2):
                row[0].font = Font(bold=True, size=10)
                row[1].font = Font(size=10)

            # Set column widths
            ws_summary.column_dimensions['A'].width = 35
            ws_summary.column_dimensions['B'].width = 15

            # --- Format Sheet 4: Instructions ---
            ws_instructions = workbook['Instructions']

            # Format headers
            for cell in ws_instructions[1]:
                cell.fill = header_fill
                cell.font = header_font
                cell.alignment = center_alignment

            # Wrap text for instructions
            for row in ws_instructions.iter_rows(min_row=2):
                row[0].font = Font(bold=True)
                row[1].alignment = wrap_alignment

            # Set column widths
            ws_instructions.column_dimensions['A'].width = 20
            ws_instructions.column_dimensions['B'].width = 80

        print(f"      Created {len(tables_review)} table reviews")
        print(f"      Created {len(columns_review)} column reviews")
        print(f"      Applied formatting with dropdowns and color coding")

    def generate_summary(self, filepath):
        """Generate executive summary"""
        with open(filepath, "w", encoding="utf-8") as f:
            f.write("# Access to PostgreSQL Migration Summary\n\n")
            f.write(f"**Source Database:** `{self.db_path}`\n\n")
            f.write(f"**Analysis Date:** {datetime.now().strftime('%Y-%m-%d %H:%M')}\n\n")

            f.write("## Overview\n\n")
            f.write("| Metric | Count |\n")
            f.write("|--------|-------|\n")
            f.write(f"| Tables | {self.report['tables']['count']} |\n")
            f.write(f"| Saved Queries | {self.report['queries']['count']} |\n")
            f.write(f"| Relationships | {self.report['relationships']['count']} |\n")

            total_rows = sum(t['row_count'] for t in self.report['table_details'] if isinstance(t['row_count'], int))
            f.write(f"| Total Rows | {total_rows:,} |\n\n")

            f.write("## Tables\n\n")
            f.write("| Access Table | PostgreSQL Table | Rows | Columns |\n")
            f.write("|--------------|------------------|------|--------|\n")
            for t in self.report["table_details"]:
                row_count = t['row_count'] if isinstance(t['row_count'], int) else 0
                f.write(f"| {t['name']} | {t['pg_name']} | {row_count:,} | {len(t['columns'])} |\n")

            f.write("\n## Potential Issues\n\n")
            issues = self.report["potential_issues"]
            f.write(f"**Total:** {issues['count']} ")
            f.write(f"(HIGH: {issues['by_severity']['HIGH']}, ")
            f.write(f"MEDIUM: {issues['by_severity']['MEDIUM']}, ")
            f.write(f"LOW: {issues['by_severity']['LOW']})\n\n")

            high_issues = [i for i in issues["details"] if i["severity"] == "HIGH"]
            if high_issues:
                f.write("### High Priority\n\n")
                for issue in high_issues:
                    f.write(f"- **{issue['type']}**: {issue['issue']}\n")


if __name__ == "__main__":
    analyzer = AccessDatabaseAnalyzerWSL(ACCESS_PATH)
    
    try:
        analyzer.analyze_all()
        analyzer.export_reports(OUTPUT_DIR)
    finally:
        pass
    
    print("\n" + "=" * 60)
    print("ANALYSIS COMPLETE")
    print("=" * 60)
    print(f"\nReview the reports in '{OUTPUT_DIR}/' folder")