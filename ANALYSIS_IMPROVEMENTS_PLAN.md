# Analysis.py Enhancement Plan for Power BI Migration

## Overview
This document outlines specific improvements to analysis.py to make it Power BI migration-ready.

---

## Current Script Strengths
✅ Good basic table/column analysis
✅ Data quality profiling
✅ Type mapping
✅ Issue identification
✅ Excel export format (already changed from CSV)

---

## Required Enhancements

### 1. Enhanced Primary Key Detection
**Current Issue:** Script notes missing PKs but doesn't detect existing ones properly

**What to Add:**
```python
def detect_primary_keys(self):
    """Detect primary keys using mdb-schema and data analysis"""
    for table in self.report["table_details"]:
        table_name = table["name"]

        # Method 1: Parse mdb-schema for PRIMARY KEY keywords
        schema = self.run_mdb_command("mdb-schema", "-T", table_name)
        if "PRIMARY KEY" in schema:
            # Parse and extract PK columns
            pass

        # Method 2: Check for ID column (auto-number)
        for col in table["columns"]:
            if col["name"].upper() == "ID" and col["type"] == "LONG INTEGER":
                table["primary_key"] = "ID"
                table["primary_key_type"] = "auto_number"

        # Method 3: Check for NOT NULL unique columns
        # Method 4: Analyze data for uniqueness
```

**Output:** Enhanced tables_summary.xlsx with PK column

---

### 2. Index Analysis
**Current Issue:** No index information captured

**What to Add:**
```python
def analyze_indexes(self):
    """Get index information from Access database"""
    indexes = []

    for table in self.report["table_details"]:
        # Parse mdb-schema --indexes output
        schema = self.run_mdb_command("mdb-schema", "-T", table_name, "--indexes")

        # Parse CREATE INDEX statements
        # Extract: index_name, table, columns, unique/non-unique

    return indexes
```

**Output:** New indexes.xlsx file with columns:
- table_name
- index_name
- columns
- is_unique
- is_primary_key
- postgres_recommendation

**Why Critical:** Power BI query performance depends on proper indexing

---

### 3. Power BI Impact Analysis Report
**NEW FEATURE**

**What to Add:**
```python
def analyze_powerbi_impact(self):
    """Analyze specific Power BI migration impacts"""
    powerbi_impacts = []

    for table in self.report["table_details"]:
        impact = {
            "access_table_name": table["name"],
            "postgres_table_name": table["pg_name"],
            "name_will_change": table["name"] != table["pg_name"],
            "m_query_update_required": "YES" if table["name"] != table["pg_name"] else "NO",
            "column_count": len(table["columns"]),
            "columns_with_name_changes": 0,
            "columns_with_special_chars": 0,
            "complexity_score": 0,  # 1-10
            "migration_risk": "",  # LOW/MEDIUM/HIGH
            "recommended_approach": "",  # DIRECT/VIEW/CUSTOM
            "example_m_query_before": f'Source = Access.Database(File.Contents("{db_path}"), [Name="{table["name"]}"])',
            "example_m_query_after": f'Source = PostgreSQL.Database("server", "database", [Query="SELECT * FROM {table["pg_name"]}"])'
        }

        # Count column issues
        for col in table["columns"]:
            if col["name"] != col["pg_name"]:
                impact["columns_with_name_changes"] += 1
            if " " in col["name"] or "(" in col["name"] or "/" in col["name"]:
                impact["columns_with_special_chars"] += 1

        # Calculate complexity score
        impact["complexity_score"] = (
            (5 if impact["name_will_change"] else 0) +
            (impact["columns_with_name_changes"] * 0.5) +
            (impact["columns_with_special_chars"] * 0.3)
        )

        # Assign risk level
        if impact["complexity_score"] >= 8:
            impact["migration_risk"] = "HIGH"
        elif impact["complexity_score"] >= 4:
            impact["migration_risk"] = "MEDIUM"
        else:
            impact["migration_risk"] = "LOW"

        powerbi_impacts.append(impact)

    return powerbi_impacts
```

**Output:** powerbi_impact_analysis.xlsx

---

### 4. Naming Mapping Document
**NEW FEATURE**

**What to Add:**
```python
def generate_naming_mapping(self):
    """Generate comprehensive before/after naming mapping"""

    # Table-level mapping
    table_mappings = []
    for table in self.report["table_details"]:
        table_mappings.append({
            "object_type": "TABLE",
            "access_name": table["name"],
            "postgres_name": table["pg_name"],
            "requires_quotes_in_access": " " in table["name"],
            "requires_quotes_in_postgres": table["name"] != table["pg_name"],
            "powerbi_search_pattern": f'[Name="{table["name"]}"]',
            "powerbi_replace_with": f'"SELECT * FROM {table["pg_name"]}"'
        })

    # Column-level mapping
    column_mappings = []
    for table in self.report["table_details"]:
        for col in table["columns"]:
            if col["name"] != col["pg_name"]:
                column_mappings.append({
                    "object_type": "COLUMN",
                    "table_access": table["name"],
                    "table_postgres": table["pg_name"],
                    "column_access": col["name"],
                    "column_postgres": col["pg_name"],
                    "change_reason": self._identify_change_reason(col["name"]),
                    "powerbi_search_pattern": f'[{col["name"]}]',
                    "powerbi_replace_with": col["pg_name"]
                })

    return table_mappings, column_mappings
```

**Output:**
- naming_mapping_tables.xlsx
- naming_mapping_columns.xlsx

---

### 5. PostgreSQL View Generator (Migration Safety)
**NEW FEATURE - CRITICAL FOR SAFE MIGRATION**

**What to Add:**
```python
def generate_compatibility_views(self, filepath):
    """Generate PostgreSQL views that preserve Access naming"""

    with open(filepath, "w") as f:
        f.write("-- PostgreSQL Compatibility Views\n")
        f.write("-- These views preserve Access table/column names\n")
        f.write("-- Use these for initial Power BI migration\n\n")

        for table in self.report["table_details"]:
            # Only create view if naming changed
            if table["name"] != table["pg_name"]:
                # Create view with Access name pointing to PostgreSQL table
                view_name = table["name"].lower().replace(" ", "_").replace("-", "_")

                f.write(f"-- View for Access table: {table['name']}\n")
                f.write(f"CREATE OR REPLACE VIEW \"{view_name}_access_compat\" AS\n")
                f.write("SELECT\n")

                # Map columns back to original names if needed
                col_mappings = []
                for col in table["columns"]:
                    if col["name"] != col["pg_name"]:
                        col_mappings.append(f'    "{col["pg_name"]}" AS "{col["name"]}"')
                    else:
                        col_mappings.append(f'    "{col["pg_name"]}"')

                f.write(",\n".join(col_mappings))
                f.write(f'\nFROM "{table["pg_name"]}";\n\n')
```

**Output:** postgresql_compatibility_views.sql

**Benefits:**
- Power BI can connect immediately after migration
- Gradual migration possible
- Rollback capability

---

### 6. Foreign Key Relationship Reconstruction
**Enhancement to Existing**

**What to Add:**
```python
def infer_foreign_keys(self):
    """Infer foreign key relationships from naming patterns and data"""
    inferred_fks = []

    # Find common patterns: _id, _code, caceis_id, etc.
    for table in self.report["table_details"]:
        for col in table["columns"]:
            col_name = col["name"].lower()

            # Pattern 1: Column name matches another table's PK
            if col_name.endswith("_id") or col_name.endswith("_code"):
                # Search for referenced table
                potential_ref = col_name.replace("_id", "").replace("_code", "")

            # Pattern 2: caceis_id appears in multiple tables
            if "caceis_id" in col_name:
                # Reference to LIST FUNDS.caceis_id

    # Validate by checking data relationships
    # Add confidence score

    return inferred_fks
```

**Output:** Enhanced relationships.xlsx with inferred relationships

---

### 7. PostgreSQL Connection String Generator
**NEW FEATURE**

**What to Add:**
```python
def generate_connection_docs(self, output_dir):
    """Generate PostgreSQL connection documentation for Power BI"""

    filepath = f"{output_dir}/powerbi_connection_guide.md"

    with open(filepath, "w") as f:
        f.write("# Power BI PostgreSQL Connection Guide\n\n")

        f.write("## Connection String Format\n\n")
        f.write("```\n")
        f.write("Server: your-postgres-server.com\n")
        f.write("Database: your_database_name\n")
        f.write("Port: 5432\n")
        f.write("```\n\n")

        f.write("## Step-by-Step Connection\n\n")
        f.write("1. Open Power BI Desktop\n")
        f.write("2. Get Data → More → PostgreSQL database\n")
        # ... detailed steps

        f.write("## M Query Examples\n\n")
        f.write("### Before (Access):\n")
        f.write("```\n")
        for table in self.report["table_details"][:3]:  # Show 3 examples
            f.write(f'Source = Access.Database(File.Contents("C:\\path\\risk.mdb"), [Name="{table["name"]}"])\n')
        f.write("```\n\n")

        f.write("### After (PostgreSQL - Direct):\n")
        f.write("```\n")
        for table in self.report["table_details"][:3]:
            f.write(f'Source = PostgreSQL.Database("server", "database")[{table["pg_name"]}]\n')
        f.write("```\n\n")

        f.write("### After (PostgreSQL - With View):\n")
        f.write("```\n")
        for table in self.report["table_details"][:3]:
            f.write(f'Source = PostgreSQL.Database("server", "database")[{table["pg_name"]}_access_compat]\n')
        f.write("```\n\n")
```

**Output:** powerbi_connection_guide.md

---

### 8. Migration Checklist Generator
**NEW FEATURE**

**What to Add:**
```python
def generate_migration_checklist(self, filepath):
    """Generate step-by-step migration checklist"""

    with open(filepath, "w") as f:
        f.write("# Access to PostgreSQL Migration Checklist\n\n")

        f.write("## Phase 1: Pre-Migration (1-2 weeks before)\n\n")
        f.write("- [ ] Run full analysis.py report\n")
        f.write("- [ ] Document all 23 Power BI semantic models\n")
        f.write("- [ ] Export all Power BI M queries\n")
        f.write("- [ ] Set up PostgreSQL test environment\n")
        f.write("- [ ] Create test data subset\n")
        f.write("- [ ] Stakeholder approval meeting\n\n")

        f.write("## Phase 2: Schema Migration\n\n")
        f.write("- [ ] Run mdb-schema to generate PostgreSQL DDL\n")
        f.write("- [ ] Add primary keys (see tables_summary.xlsx)\n")
        f.write("- [ ] Create indexes (see indexes.xlsx)\n")
        f.write(f"- [ ] Add foreign keys (see relationships.xlsx)\n")
        f.write("- [ ] Create compatibility views (run postgresql_compatibility_views.sql)\n")
        f.write("- [ ] Verify schema in test environment\n\n")

        f.write("## Phase 3: Data Migration\n\n")
        f.write(f"- [ ] Export data using mdb-export for all {self.report['tables']['count']} tables\n")
        f.write("- [ ] Transform data (handle dates, booleans, nulls)\n")
        f.write("- [ ] Import to PostgreSQL using COPY\n")
        f.write("- [ ] Run data validation queries\n")
        f.write("- [ ] Compare row counts (Access vs PostgreSQL)\n\n")

        f.write("## Phase 4: Power BI Migration (Per Semantic Model)\n\n")
        f.write("### For each of 23 semantic models:\n")
        f.write("- [ ] 1. Duplicate semantic model (create backup)\n")
        f.write("- [ ] 2. Update data source to PostgreSQL\n")
        f.write("- [ ] 3. Update M queries (use naming_mapping.xlsx)\n")
        f.write("- [ ] 4. Refresh data model\n")
        f.write("- [ ] 5. Verify all tables loaded\n")
        f.write("- [ ] 6. Test DAX measures\n")
        f.write("- [ ] 7. Test reports/visuals\n")
        f.write("- [ ] 8. User acceptance testing\n")
        f.write("- [ ] 9. Deploy to production workspace\n\n")

        f.write("## Phase 5: Validation\n\n")
        f.write("- [ ] Compare Access vs PostgreSQL data\n")
        f.write("- [ ] Performance testing (query response times)\n")
        f.write("- [ ] Verify scheduled refreshes work\n")
        f.write("- [ ] Check all dashboards render correctly\n\n")

        f.write("## Phase 6: Cutover\n\n")
        f.write("- [ ] Communication to all users\n")
        f.write("- [ ] Switch production semantic models\n")
        f.write("- [ ] Monitor for 1 week\n")
        f.write("- [ ] Decommission Access database\n")
        f.write("- [ ] Remove compatibility views (optional, after 3 months)\n\n")

        # Add table-specific notes
        f.write("## Table-Specific Notes\n\n")
        for table in self.report["table_details"]:
            if table["name"] != table["pg_name"]:
                f.write(f"- **{table['name']}** → `{table['pg_name']}`: ")
                f.write(f"Update in {self._estimate_powerbi_usage(table['name'])} semantic models\n")
```

**Output:** migration_checklist.md

---

### 9. Power BI Query Complexity Analysis
**NEW FEATURE**

**What to Add:**
```python
def analyze_query_complexity(self):
    """Estimate query complexity for Power BI planning"""

    complexity = []

    for table in self.report["table_details"]:
        entry = {
            "table": table["name"],
            "row_count": table["row_count"],
            "column_count": len(table["columns"]),
            "has_memo_fields": any(c["type"] == "MEMO/HYPERLINK" for c in table["columns"]),
            "refresh_time_estimate": self._estimate_refresh_time(table),
            "powerquery_folding_risk": self._assess_folding_risk(table),
            "recommended_refresh_frequency": self._recommend_refresh(table)
        }
        complexity.append(entry)

    return complexity
```

**Output:** powerbi_performance_analysis.xlsx

---

## Implementation Priority

### Must-Have (Before Migration)
1. ✅ Power BI Impact Analysis
2. ✅ Naming Mapping Document
3. ✅ PostgreSQL View Generator
4. ✅ Migration Checklist

### Should-Have (Very Helpful)
5. ✅ Enhanced Primary Key Detection
6. ✅ Index Analysis
7. ✅ Connection String Generator

### Nice-to-Have (Future Enhancement)
8. Foreign Key Inference
9. Query Complexity Analysis

---

## New Files Generated After Enhancement

| File | Purpose | Critical? |
|------|---------|-----------|
| powerbi_impact_analysis.xlsx | Shows migration impact per table | ✅ YES |
| naming_mapping_tables.xlsx | Before/after table names | ✅ YES |
| naming_mapping_columns.xlsx | Before/after column names | ✅ YES |
| postgresql_compatibility_views.sql | Safety views for gradual migration | ✅ YES |
| migration_checklist.md | Step-by-step guide | ✅ YES |
| powerbi_connection_guide.md | Connection documentation | ✅ YES |
| indexes.xlsx | Index analysis | 🟡 IMPORTANT |
| powerbi_performance_analysis.xlsx | Performance planning | 🟢 NICE |

---

## Code Structure Changes

### New Methods to Add:
```python
class AccessDatabaseAnalyzerWSL:
    # Existing methods...

    # NEW METHODS:
    def detect_primary_keys(self)           # Enhancement #1
    def analyze_indexes(self)                # Enhancement #2
    def analyze_powerbi_impact(self)         # Enhancement #3
    def generate_naming_mapping(self)        # Enhancement #4
    def generate_compatibility_views(self)   # Enhancement #5
    def infer_foreign_keys(self)            # Enhancement #6
    def generate_connection_docs(self)       # Enhancement #7
    def generate_migration_checklist(self)   # Enhancement #8
    def analyze_query_complexity(self)       # Enhancement #9

    # MODIFIED METHOD:
    def export_reports(self, output_dir):
        # Existing exports...

        # NEW EXPORTS:
        # 10. Power BI Impact Analysis
        powerbi_impacts = self.analyze_powerbi_impact()
        pd.DataFrame(powerbi_impacts).to_excel(
            f"{output_dir}/powerbi_impact_analysis.xlsx", index=False
        )

        # 11. Naming Mappings
        table_map, col_map = self.generate_naming_mapping()
        pd.DataFrame(table_map).to_excel(
            f"{output_dir}/naming_mapping_tables.xlsx", index=False
        )
        pd.DataFrame(col_map).to_excel(
            f"{output_dir}/naming_mapping_columns.xlsx", index=False
        )

        # 12. Compatibility Views
        self.generate_compatibility_views(
            f"{output_dir}/postgresql_compatibility_views.sql"
        )

        # 13. Connection Guide
        self.generate_connection_docs(output_dir)

        # 14. Migration Checklist
        self.generate_migration_checklist(
            f"{output_dir}/migration_checklist.md"
        )

        # 15. Indexes
        if self.report.get("indexes"):
            pd.DataFrame(self.report["indexes"]).to_excel(
                f"{output_dir}/indexes.xlsx", index=False
            )
```

---

## Estimated Implementation Time

| Enhancement | Complexity | Time |
|-------------|-----------|------|
| #1 Primary Key Detection | Medium | 2 hours |
| #2 Index Analysis | Medium | 2 hours |
| #3 Power BI Impact | Low | 1 hour |
| #4 Naming Mapping | Low | 1 hour |
| #5 Compatibility Views | Medium | 2 hours |
| #6 FK Inference | High | 4 hours |
| #7 Connection Docs | Low | 1 hour |
| #8 Migration Checklist | Low | 1 hour |
| #9 Query Complexity | Medium | 2 hours |
| **TOTAL** | | **16 hours** |

For Phase 1 (Must-Have only): **~8 hours**

---

## Testing Plan

After implementation, test with:
1. Run against risk.mdb
2. Verify all Excel files generate
3. Verify SQL files are valid
4. Manually review naming mappings
5. Test compatibility views in PostgreSQL
6. Validate migration checklist completeness

---

## Next Steps

1. ✅ Review this plan
2. Get stakeholder approval
3. Implement enhancements (in priority order)
4. Test with risk.mdb
5. Generate full analysis report
6. Begin migration planning

---

**Plan End**
