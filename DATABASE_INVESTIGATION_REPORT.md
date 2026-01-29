# Access to PostgreSQL Migration - Database Investigation Report

**Database:** risk.mdb
**Investigation Date:** 2026-01-29
**Purpose:** Pre-migration analysis for PostgreSQL with Power BI integration

---

## Executive Summary

### Critical Findings

🔴 **HIGH PRIORITY - NAMING ISSUES**
- **48 out of 52 tables** have naming issues (spaces, hyphens, special characters)
- **~80% of columns** contain spaces, parentheses, or special characters
- These WILL break Power BI queries after migration unless handled properly

🟡 **MEDIUM PRIORITY**
- No foreign key relationships detected (may need manual recreation)
- Multiple data types need careful mapping (Memo/Hyperlink, Single/Double)
- Several tables appear to be configuration/lookup data

🟢 **GOOD NEWS**
- No saved queries to migrate
- Moderate data volume (manageable for migration)
- No obvious SQL reserved word conflicts in table names

---

## Database Overview

| Metric | Value |
|--------|-------|
| Total Tables | 52 |
| Tables with Spaces in Name | 41 |
| Tables with Hyphens in Name | 11 |
| Saved Queries | 0 |
| Foreign Key Relationships | 0 (detected) |

---

## CRITICAL: Naming Issues for Power BI

### Table Name Issues

#### Tables with Spaces (41 tables)
These will be transformed to PostgreSQL-friendly names:

| Current Access Name | Proposed PostgreSQL Name | Power BI Impact |
|---------------------|-------------------------|-----------------|
| `BT Comments` | `bt_comments` | HIGH - M query needs update |
| `LIST FUNDS` | `list_funds` | HIGH - M query needs update |
| `Comment Structured product` | `comment_structured_product` | HIGH - M query needs update |
| `Comments Dashboard` | `comments_dashboard` | HIGH - M query needs update |
| `Comments Investors Breakdown` | `comments_investors_breakdown` | HIGH - M query needs update |
| `Comments RnC` | `comments_rnc` | HIGH - M query needs update |
| `Copy Of Fichier_Finalyse` | `copy_of_fichier_finalyse` | HIGH - M query needs update |
| `Country ratings table` | `country_ratings_table` | HIGH - M query needs update |
| `ESG MAPPING` | `esg_mapping` | HIGH - M query needs update |
| `ESG Thresholds` | `esg_thresholds` | HIGH - M query needs update |
| `Funds - Ref Date` | `funds_ref_date` | HIGH - M query needs update |
| `Investors Ranking` | `investors_ranking` | HIGH - M query needs update |
| `Italian Opp - LIST 1` | `italian_opp_list_1` | HIGH - M query needs update |
| `Italian Opp - LIST 2` | `italian_opp_list_2` | HIGH - M query needs update |
| `Limit Commitment` | `limit_commitment` | HIGH - M query needs update |
| `Liquidity bonds` | `liquidity_bonds` | HIGH - M query needs update |
| `List LiqRepport - Ref Date` | `list_liqrepport_ref_date` | HIGH - M query needs update |
| `List LiqRepport - Ref Date agg` | `list_liqrepport_ref_date_agg` | HIGH - M query needs update |
| `List_Exception Table` | `list_exception_table` | HIGH - M query needs update |
| `List_Liquidity Override` | `list_liquidity_override` | HIGH - M query needs update |
| `Paste Errors` | `paste_errors` | HIGH - M query needs update |
| `Sector - Matching table` | `sector_matching_table` | HIGH - M query needs update |
| `Sector - Matching table - details` | `sector_matching_table_details` | HIGH - M query needs update |
| `Specific Limits` | `specific_limits` | HIGH - M query needs update |
| `Statique dashboard` | `statique_dashboard` | HIGH - M query needs update |
| `Structured Product` | `structured_product` | HIGH - M query needs update |
| `Swing rate` | `swing_rate` | HIGH - M query needs update |
| `Table Countries` | `table_countries` | HIGH - M query needs update |
| `xxx List LiqRepport - Ref Date` | `xxx_list_liqrepport_ref_date` | HIGH - M query needs update |
| `Asset Type RNC` | `asset_type_rnc` | HIGH - M query needs update |
| `Exception Commodities` | `exception_commodities` | HIGH - M query needs update |
| `Liquidity Funds` | `liquidity_funds` | HIGH - M query needs update |
| `List_Mapping ptf` | `list_mapping_ptf` | HIGH - M query needs update |

### Column Name Issues - Critical Examples

#### Columns with Special Characters
| Table | Current Column | PostgreSQL Column | Impact |
|-------|----------------|-------------------|--------|
| BT Comments | `Validation (Y/N)` | `validation_y_n` | HIGH |
| Investors Ranking | `% of Fund NAV` | `percent_of_fund_nav` | HIGH |
| ESG Thresholds | `E/S ALIGNMENT` | `e_s_alignment` | HIGH |
| Manual Input | `value (not perc)` | `value_not_perc` | HIGH |
| Specific Limits | `limit min (not perc)` | `limit_min_not_perc` | HIGH |
| List_Exception Table | `Exception Rule (name is issued from the XL report)` | `exception_rule_name_is_issued_from_the_xl_report` | HIGH |

#### Columns with Spaces (Examples from key tables)
| Table | Affected Columns |
|-------|------------------|
| LIST FUNDS | `ptf_name` (no change needed) |
| CLASSIF_COUNTRY_GEO | `Ctry Name FR`, `Ctry Name EN`, `Ctry Name GE`, `Region WOP`, `Region EOP` |
| Comments Dashboard | `comments GE Dashboard`, `comments ESG dashboard` |
| Country ratings table | `Rating Issuer SP`, `Rating Issuer Moody`, `SP in figures`, `Moody's in figures` |
| Funds - Ref Date | `Code compartiment`, `Date ref`, `Sub-Manager` |

---

## Data Type Mapping Considerations

### Access to PostgreSQL Type Conversions

| Access Type | Count | PostgreSQL Type | Power BI Interpretation | Notes |
|-------------|-------|-----------------|------------------------|-------|
| Text(255) | ~350 | VARCHAR(255) | Text | ✅ No issues |
| Long Integer | ~60 | INTEGER | Whole Number | ✅ No issues |
| Double | ~25 | DOUBLE PRECISION | Decimal Number | ✅ No issues |
| DateTime | ~35 | TIMESTAMP | Date/Time | ✅ No issues |
| Boolean | ~8 | BOOLEAN | True/False | ✅ No issues |
| Single | ~15 | REAL | Decimal Number | ⚠️ Precision change |
| Memo/Hyperlink | ~18 | TEXT | Text | ⚠️ Large text fields |
| Integer | ~1 | SMALLINT | Whole Number | ✅ No issues |

### Special Attention Required

**Memo/Hyperlink Fields** (18 instances):
- Comments, RULES, Termsheet columns
- Will become TEXT in PostgreSQL
- Power BI may need refresh if these fields are used in measures

---

## Table Analysis by Category

### Configuration/Lookup Tables (Low data volume, high importance)
```
LIST_G10_CURRENCIES          - Currency classifications
List_Ratings                 - Rating mappings (Moody, S&P, Fitch)
Country ratings table        - Country credit ratings
CLASSIF_COUNTRY_GEO         - Geographic classifications
Table Countries             - Country master data
Secteurs                    - Sector mappings
ESG MAPPING                 - ESG scoring configuration (20 rows)
ESG Thresholds              - ESG limit configuration
```

### Core Business Tables (Active Power BI usage expected)
```
LIST FUNDS                  - 29 funds (core reference)
List_Mapping ptf           - 29 portfolios (core reference)
Specific Limits            - 294 limit definitions
Comments RnC               - 92 compliance comments
Manual Input               - Manual adjustments
Manual Input Date          - Date-specific manual inputs
Limit Commitment           - Fund commitment limits
Statique dashboard         - Dashboard static configuration
```

### Operational/Control Tables
```
Comments Dashboard
Comments Investors Breakdown
Comment Structured product
Structured Product
Swing rate
Investors Ranking
Param Commitment
```

### Securities Lending Tables
```
Seclend_Authorized_Countries
Seclend_Authorized_Index
Seclend_Authorized_Rating
Seclend_Authorized_Sector
Seclend_Non-Authorized_Securities
Seclend_Rating_Ctry Issuer
```

### Liquidity Management Tables
```
Liquidity bonds
Liquidity Funds
List_Liquidity Override
LIST_param_Liquidity
LIST_param_Liquidity_Bonds
LIST_param_Liquidity_Equity
LIST_param_Liquidity_Override
LIST_param_Liquidity_Redem_Freq
List LiqRepport - Ref Date
List LiqRepport - Ref Date agg
```

### Exception/Special Case Tables
```
List_Exception Table
Exception Commodities
Paste Errors               - Likely error log/staging
Copy Of Fichier_Finalyse   - Backup/copy table
xxx List LiqRepport - Ref Date - Deprecated/test table
```

---

## Primary Key Analysis

### Tables with NOT NULL Constraints (Potential PKs)
| Table | Column | Type | Likely PK? |
|-------|--------|------|-----------|
| LIST FUNDS | caceis_id | Long Integer | ✅ YES |
| CLASSIF_COUNTRY_GEO | Exotic | Boolean | ❌ NO |
| LIST_param_Liquidity_Override | ISIN | Text(255) | ✅ YES |
| LIST_param_Liquidity_Redem_Freq | REDEM_FREQ | Text(255) | ✅ YES |
| List_Ptf_Limit | caceis_id | Text(255) | ✅ YES |
| List_Rating_Counterparties | custodian_code, custodian_description | Text(255) | ✅ COMPOSITE |
| List_Risk_Type | Risk Type | Text(255) | ✅ YES |
| LIST_SRM - Not Covered | TFS Valuation | Boolean | ❌ NO |
| Table Countries | Exotic | Boolean | ❌ NO |
| List_Ratings | CT, LT | Boolean | ❌ NO |

### Tables with ID Fields (Likely Auto-number PKs)
- BT Comments (ID)
- Comment Structured product (ID)
- Comments Dashboard (ID)
- Comments Investors Breakdown (ID)
- Comments RnC (ID)
- ESG MAPPING (ID)
- ESG Thresholds (ID)
- Investors Ranking (ID)
- Italian Opp - LIST 1 (ID)
- Italian Opp - LIST 2 (ID)
- Limit Commitment (ID)
- Manual Input (ID)
- Manual Input Date (ID)
- Param Commitment (ID)
- Specific Limits (ID)
- Statique dashboard (ID)
- Structured Product (ID)
- Swing rate (ID)
- Asset Type RNC (ID)
- List_Mapping ptf (ID)

---

## Power BI Integration Impact Assessment

### 🔴 CRITICAL IMPACT - Immediate Action Required

#### 1. All Table References Need Update
Every Power BI dataset connecting to this database will need:
- Updated table names in M queries
- Updated column names in M queries
- Refreshed data model
- Retested all DAX measures
- Retested all relationships

#### 2. Semantic Models Requiring Updates (23 identified)
Based on your list, these models will ALL need updates:
- Contingent Convertible Bonds Monitoring
- Control Global Exposure
- Control Holdings Masterdata
- Control Portfolio (MGSTA4)
- Control Pricing
- Counterparty Exposure Report
- (... and 17 more)

#### 3. Reports Requiring Updates (14+ identified)
All paginated reports will need:
- Connection string updates
- Query validation
- Visual retesting

---

## Recommendations

### Phase 1: Pre-Migration (DO THIS FIRST)
1. ✅ Run the enhanced analysis.py script (after improvements)
2. ✅ Create a naming convention mapping document
3. ✅ Document all Power BI M queries BEFORE migration
4. ✅ Create a PostgreSQL connection test environment
5. ✅ Test one Power BI semantic model end-to-end with new schema

### Phase 2: Migration Strategy
**Option A: Direct Migration with Breaking Changes (Faster but risky)**
- Migrate all table/column names to PostgreSQL-friendly format
- Update all Power BI connections at once
- Requires synchronized cutover (high risk)

**Option B: Gradual Migration with Views (Safer, recommended)**
- Migrate to PostgreSQL with clean naming
- Create PostgreSQL VIEWS with original Access names
- Update Power BI connections to use views initially
- Gradually update Power BI to use base tables
- Remove views when all updates complete

### Phase 3: Post-Migration
1. Create indexes on foreign key columns
2. Add proper primary keys where missing
3. Create foreign key constraints
4. Performance testing with Power BI
5. Data validation queries

---

## Specific Concerns for Your Use Case

### 1. caceis_id Field
Used in multiple tables as a join key:
- LIST FUNDS (NOT NULL) - 29 rows
- List_Mapping ptf - 29 rows
- Comments Dashboard
- Comments RnC
- Manual Input
- Manual Input Date
- Param Commitment
- Statique dashboard
- List_Ptf_Limit

**Action:** Ensure this becomes a proper foreign key in PostgreSQL

### 2. ESG Dashboards
Tables affected:
- ESG MAPPING
- ESG Thresholds
- Comments Dashboard (`comments ESG dashboard`)
- Comments RnC (`Comments ESG`)

**Action:** Coordinate with ESG Risk Dashboard owner for testing

### 3. Liquidity Reporting
Complex table structure with date references:
- List LiqRepport - Ref Date
- List LiqRepport - Ref Date agg
- xxx List LiqRepport - Ref Date (deprecated?)

**Action:** Understand which is current, archive the rest

---

## Next Steps - Immediate Actions

1. **Review this report** with stakeholders
2. **Decide on migration strategy** (Option A vs Option B)
3. **Run enhanced analysis.py** (after we improve it)
4. **Create Power BI query inventory** (extract all M queries)
5. **Set up PostgreSQL test environment**
6. **Test with one semantic model first** (recommend starting with simplest one)

---

## Files to Be Generated

After improvements to analysis.py, you will get:
- ✅ tables_summary.xlsx - Table comparison
- ✅ columns_detail.xlsx - Column mapping
- ✅ issues.xlsx - Migration issues
- ✅ data_quality.xlsx - Data profiling
- ✅ postgresql_schema.sql - PostgreSQL DDL
- ✅ MIGRATION_SUMMARY.md - Summary report
- 🆕 powerbi_impact_analysis.xlsx - Power BI specific impact
- 🆕 naming_mapping.xlsx - Before/after naming
- 🆕 postgres_connection_string.txt - New connection details
- 🆕 migration_checklist.md - Step-by-step guide

---

**Report End**
