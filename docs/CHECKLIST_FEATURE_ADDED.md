# Migration Review Checklist - Feature Added

## What Was Added

A new comprehensive Excel export: **migration_review_checklist.xlsx**

This file will be generated automatically when you run analysis.py and contains 4 sheets for stakeholder review.

---

## Sheet 1: Tables_Review

**Purpose:** Review all 52 tables and decide what to migrate

**Columns:**
- `Table_Name_Access` - Current table name
- `Table_Name_PostgreSQL` - Future PostgreSQL name
- `Row_Count` - Number of rows
- `Column_Count` - Number of columns
- `Name_Will_Change` - YES/NO if name changes
- `Estimated_Status` - ACTIVE/DEPRECATED/EMPTY (auto-detected)
- `Suggested_Priority` - HIGH/MEDIUM/LOW (auto-suggested)
- `Issues_Count` - Number of migration issues
- **`DECISION_Keep_or_Discard`** ← *Empty for you to fill (KEEP/DISCARD/REVIEW)*
- **`DECISION_Final_Priority`** ← *Empty for you to fill (CRITICAL/HIGH/MEDIUM/LOW)*
- **`DECISION_Notes`** ← *Empty for comments*
- **`Used_in_PowerBI`** ← *Empty for you to mark (YES/NO)*

**Auto-Detection Features:**
- Tables starting with "xxx" → marked as DEPRECATED
- "Paste Error" or "Copy Of" tables → marked as DEPRECATED
- Empty tables (0 rows) → marked as EMPTY
- Tables with >100 rows → suggested as HIGH priority
- Tables with >20 rows → suggested as MEDIUM priority

---

## Sheet 2: Columns_Review

**Purpose:** Review all columns and decide what to keep

**Columns:**
- `Table_Name` - Which table this column belongs to
- `Column_Name_Access` - Current column name
- `Column_Name_PostgreSQL` - Future PostgreSQL name
- `Data_Type` - Column data type
- `Size` - Field size
- `Nullable` - YES/NO if allows nulls
- `Name_Will_Change` - YES/NO if name changes
- `Has_Special_Characters` - YES/NO (spaces, parentheses, etc.)
- `Null_Percent` - Percentage of null values
- `Distinct_Count` - Number of unique values
- `Sample_Values` - Examples of data in this column
- `Suggested_Action` - KEEP/REVIEW (auto-suggested)
- **`DECISION_Keep_or_Discard`** ← *Empty for you to fill*
- **`DECISION_Notes`** ← *Empty for comments*

**Auto-Detection Features:**
- Generic column names (F1, F2, F10) → suggested as REVIEW
- Shows sample data to help you decide if column is useful
- Shows null percentage to identify mostly-empty columns

---

## Sheet 3: Summary_Dashboard

**Purpose:** Quick overview statistics

Shows:
- Total tables (broken down by status)
- Total columns (with name change counts)
- Total data rows
- Total issues by severity

---

## Sheet 4: Instructions

**Purpose:** User guide for filling out the checklist

Contains step-by-step instructions on:
- How to use each sheet
- What to look for (deprecated tables, empty columns, etc.)
- Priority definitions
- Decision guidelines

---

## Example Use Cases

### Example 1: Identifying Deprecated Tables

The checklist will highlight tables like:
```
xxx List LiqRepport - Ref Date
├─ Estimated_Status: DEPRECATED (starts with xxx)
├─ Row_Count: 0
└─ Suggested_Priority: LOW

Your Decision: DECISION_Keep_or_Discard = "DISCARD"
               DECISION_Notes = "Old test table, not used"
```

### Example 2: Critical Business Tables

```
LIST FUNDS
├─ Row_Count: 29
├─ Estimated_Status: ACTIVE
├─ Suggested_Priority: HIGH
└─ Issues_Count: 2 (name changes)

Your Decision: DECISION_Keep_or_Discard = "KEEP"
               DECISION_Final_Priority = "CRITICAL"
               Used_in_PowerBI = "YES"
               DECISION_Notes = "Core reference table for all fund data"
```

### Example 3: Identifying Unused Columns

```
Column: F10 in table "Param Commitment"
├─ Null_Percent: 100%
├─ Distinct_Count: 0
└─ Suggested_Action: REVIEW

Your Decision: DECISION_Keep_or_Discard = "DISCARD"
               DECISION_Notes = "Generic column name, always empty"
```

---

## Workflow Recommendation

### Step 1: Initial Review (Database Team)
1. Run analysis.py to generate migration_review_checklist.xlsx
2. Database team does first pass review
3. Fill in obvious cases (deprecated tables, empty columns)

### Step 2: Business Review (Power BI Owners)
1. Share checklist with Matheo LUINO and other Power BI owners
2. They fill in "Used_in_PowerBI" column
3. They mark CRITICAL vs HIGH priority based on business importance

### Step 3: Final Decision (Migration Team)
1. Review all decisions
2. Resolve any "REVIEW" items
3. Create final migration scope
4. Use completed checklist to plan migration order

### Step 4: Implementation
1. Migrate CRITICAL tables first
2. Test Power BI with CRITICAL tables
3. Gradually migrate HIGH, MEDIUM, LOW
4. Skip all DISCARD tables

---

## Benefits

✅ **Comprehensive** - Every table and column reviewed
✅ **Data-Driven** - Auto-suggestions based on actual usage
✅ **Collaborative** - Multiple stakeholders can contribute
✅ **Documented** - Notes column captures reasoning
✅ **Reduces Risk** - Prevents migrating unused/obsolete data
✅ **Saves Time** - No need to migrate everything blindly

---

## Sample Decisions You Might Make

### Tables to DISCARD
- `xxx List LiqRepport - Ref Date` (deprecated)
- `Paste Errors` (error log/staging)
- `Copy Of Fichier_Finalyse` (backup copy)
- Any tables with 0 rows

### Tables to KEEP as CRITICAL
- `LIST FUNDS` (core reference)
- `List_Mapping ptf` (portfolio mappings)
- `Specific Limits` (active limits)
- `Comments RnC` (compliance data)
- All ESG tables (if ESG dashboard is critical)

### Columns to DISCARD
- Generic names (F1, F2, F10, F11, F12, F13)
- Columns with 100% null values
- Duplicate columns (if you find any)
- Columns marked as "not used anymore"

---

## Next Steps

1. ✅ Run analysis.py (I've updated it)
2. ✅ Open migration_review_checklist.xlsx
3. ✅ Review Sheet 4 (Instructions)
4. ✅ Start filling in DECISION columns
5. ✅ Share with stakeholders
6. ✅ Finalize migration scope

---

**File will be generated at:** `access_analysis/migration_review_checklist.xlsx`

**Ready to run the analysis!**
