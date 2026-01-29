-- Data Validation Queries for PostgreSQL
-- Run these after data migration to verify integrity
-- Generated: 2026-01-29 11:16:15.360320

-- =====================================
-- SECTION 1: Row Count Validation
-- =====================================

-- Validate row count for: BT Comments
SELECT
    'bt_comments' as table_name,
    COUNT(*) as actual_rows,
    37 as expected_rows,
    CASE
        WHEN COUNT(*) = 37 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "bt_comments";

-- Validate row count for: CLASSIF_COUNTRY_GEO
SELECT
    'classif_country_geo' as table_name,
    COUNT(*) as actual_rows,
    257 as expected_rows,
    CASE
        WHEN COUNT(*) = 257 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "classif_country_geo";

-- Validate row count for: Comment Structured product
SELECT
    'comment_structured_product' as table_name,
    COUNT(*) as actual_rows,
    3 as expected_rows,
    CASE
        WHEN COUNT(*) = 3 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "comment_structured_product";

-- Validate row count for: Comments Dashboard
SELECT
    'comments_dashboard' as table_name,
    COUNT(*) as actual_rows,
    29 as expected_rows,
    CASE
        WHEN COUNT(*) = 29 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "comments_dashboard";

-- Validate row count for: Comments Investors Breakdown
SELECT
    'comments_investors_breakdown' as table_name,
    COUNT(*) as actual_rows,
    270 as expected_rows,
    CASE
        WHEN COUNT(*) = 270 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "comments_investors_breakdown";

-- Validate row count for: Comments RnC
SELECT
    'comments_rnc' as table_name,
    COUNT(*) as actual_rows,
    87 as expected_rows,
    CASE
        WHEN COUNT(*) = 87 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "comments_rnc";

-- Validate row count for: Copy Of Fichier_Finalyse
SELECT
    'copy_of_fichier_finalyse' as table_name,
    COUNT(*) as actual_rows,
    196 as expected_rows,
    CASE
        WHEN COUNT(*) = 196 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "copy_of_fichier_finalyse";

-- Validate row count for: Country ratings table
SELECT
    'country_ratings_table' as table_name,
    COUNT(*) as actual_rows,
    199 as expected_rows,
    CASE
        WHEN COUNT(*) = 199 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "country_ratings_table";

-- Validate row count for: ESG MAPPING
SELECT
    'esg_mapping' as table_name,
    COUNT(*) as actual_rows,
    19 as expected_rows,
    CASE
        WHEN COUNT(*) = 19 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "esg_mapping";

-- Validate row count for: ESG Thresholds
SELECT
    'esg_thresholds' as table_name,
    COUNT(*) as actual_rows,
    28 as expected_rows,
    CASE
        WHEN COUNT(*) = 28 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "esg_thresholds";

-- Validate row count for: Fichier_Finalyse
SELECT
    'fichier_finalyse' as table_name,
    COUNT(*) as actual_rows,
    160 as expected_rows,
    CASE
        WHEN COUNT(*) = 160 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "fichier_finalyse";

-- Validate row count for: Funds - Ref Date
SELECT
    'funds___ref_date' as table_name,
    COUNT(*) as actual_rows,
    32 as expected_rows,
    CASE
        WHEN COUNT(*) = 32 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "funds___ref_date";

-- Validate row count for: Investors Ranking
SELECT
    'investors_ranking' as table_name,
    COUNT(*) as actual_rows,
    70 as expected_rows,
    CASE
        WHEN COUNT(*) = 70 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "investors_ranking";

-- Validate row count for: Italian Opp - LIST 1
SELECT
    'italian_opp___list_1' as table_name,
    COUNT(*) as actual_rows,
    58 as expected_rows,
    CASE
        WHEN COUNT(*) = 58 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "italian_opp___list_1";

-- Validate row count for: Italian Opp - LIST 2
SELECT
    'italian_opp___list_2' as table_name,
    COUNT(*) as actual_rows,
    78 as expected_rows,
    CASE
        WHEN COUNT(*) = 78 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "italian_opp___list_2";

-- Validate row count for: Limit Commitment
SELECT
    'limit_commitment' as table_name,
    COUNT(*) as actual_rows,
    28 as expected_rows,
    CASE
        WHEN COUNT(*) = 28 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "limit_commitment";

-- Validate row count for: Liquidity bonds
SELECT
    'liquidity_bonds' as table_name,
    COUNT(*) as actual_rows,
    5 as expected_rows,
    CASE
        WHEN COUNT(*) = 5 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "liquidity_bonds";

-- Validate row count for: LIST FUNDS
SELECT
    'list_funds' as table_name,
    COUNT(*) as actual_rows,
    28 as expected_rows,
    CASE
        WHEN COUNT(*) = 28 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_funds";

-- Validate row count for: List LiqRepport - Ref Date
SELECT
    'list_liqrepport___ref_date' as table_name,
    COUNT(*) as actual_rows,
    257 as expected_rows,
    CASE
        WHEN COUNT(*) = 257 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_liqrepport___ref_date";

-- Validate row count for: List LiqRepport - Ref Date agg
SELECT
    'list_liqrepport___ref_date_agg' as table_name,
    COUNT(*) as actual_rows,
    25 as expected_rows,
    CASE
        WHEN COUNT(*) = 25 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_liqrepport___ref_date_agg";

-- Validate row count for: List_Exception Table
SELECT
    'list_exception_table' as table_name,
    COUNT(*) as actual_rows,
    13 as expected_rows,
    CASE
        WHEN COUNT(*) = 13 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_exception_table";

-- Validate row count for: LIST_G10_CURRENCIES
SELECT
    'list_g10_currencies' as table_name,
    COUNT(*) as actual_rows,
    10 as expected_rows,
    CASE
        WHEN COUNT(*) = 10 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_g10_currencies";

-- Validate row count for: List_Liquidity Override
SELECT
    'list_liquidity_override' as table_name,
    COUNT(*) as actual_rows,
    0 as expected_rows,
    CASE
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_liquidity_override";

-- Validate row count for: LIST_param_Liquidity
SELECT
    'list_param_liquidity' as table_name,
    COUNT(*) as actual_rows,
    27 as expected_rows,
    CASE
        WHEN COUNT(*) = 27 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_param_liquidity";

-- Validate row count for: LIST_param_Liquidity_Bonds
SELECT
    'list_param_liquidity_bonds' as table_name,
    COUNT(*) as actual_rows,
    5 as expected_rows,
    CASE
        WHEN COUNT(*) = 5 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_param_liquidity_bonds";

-- Validate row count for: LIST_param_Liquidity_Equity
SELECT
    'list_param_liquidity_equity' as table_name,
    COUNT(*) as actual_rows,
    1 as expected_rows,
    CASE
        WHEN COUNT(*) = 1 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_param_liquidity_equity";

-- Validate row count for: LIST_param_Liquidity_Override
SELECT
    'list_param_liquidity_override' as table_name,
    COUNT(*) as actual_rows,
    263 as expected_rows,
    CASE
        WHEN COUNT(*) = 263 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_param_liquidity_override";

-- Validate row count for: LIST_param_Liquidity_Redem_Freq
SELECT
    'list_param_liquidity_redem_freq' as table_name,
    COUNT(*) as actual_rows,
    12 as expected_rows,
    CASE
        WHEN COUNT(*) = 12 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_param_liquidity_redem_freq";

-- Validate row count for: List_Ptf_Limit
SELECT
    'list_ptf_limit' as table_name,
    COUNT(*) as actual_rows,
    19 as expected_rows,
    CASE
        WHEN COUNT(*) = 19 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_ptf_limit";

-- Validate row count for: List_Rating_Counterparties
SELECT
    'list_rating_counterparties' as table_name,
    COUNT(*) as actual_rows,
    14 as expected_rows,
    CASE
        WHEN COUNT(*) = 14 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_rating_counterparties";

-- Validate row count for: List_Risk_Type
SELECT
    'list_risk_type' as table_name,
    COUNT(*) as actual_rows,
    6 as expected_rows,
    CASE
        WHEN COUNT(*) = 6 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_risk_type";

-- Validate row count for: LIST_SRM - Not Covered
SELECT
    'list_srm___not_covered' as table_name,
    COUNT(*) as actual_rows,
    148 as expected_rows,
    CASE
        WHEN COUNT(*) = 148 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_srm___not_covered";

-- Validate row count for: Manual Input
SELECT
    'manual_input' as table_name,
    COUNT(*) as actual_rows,
    5 as expected_rows,
    CASE
        WHEN COUNT(*) = 5 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "manual_input";

-- Validate row count for: Manual Input Date
SELECT
    'manual_input_date' as table_name,
    COUNT(*) as actual_rows,
    36 as expected_rows,
    CASE
        WHEN COUNT(*) = 36 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "manual_input_date";

-- Validate row count for: Param Commitment
SELECT
    'param_commitment' as table_name,
    COUNT(*) as actual_rows,
    19 as expected_rows,
    CASE
        WHEN COUNT(*) = 19 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "param_commitment";

-- Validate row count for: Paste Errors
SELECT
    'paste_errors' as table_name,
    COUNT(*) as actual_rows,
    1 as expected_rows,
    CASE
        WHEN COUNT(*) = 1 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "paste_errors";

-- Validate row count for: Seclend_Authorized_Countries
SELECT
    'seclend_authorized_countries' as table_name,
    COUNT(*) as actual_rows,
    37 as expected_rows,
    CASE
        WHEN COUNT(*) = 37 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "seclend_authorized_countries";

-- Validate row count for: Seclend_Authorized_Index
SELECT
    'seclend_authorized_index' as table_name,
    COUNT(*) as actual_rows,
    22 as expected_rows,
    CASE
        WHEN COUNT(*) = 22 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "seclend_authorized_index";

-- Validate row count for: Seclend_Authorized_Rating
SELECT
    'seclend_authorized_rating' as table_name,
    COUNT(*) as actual_rows,
    8 as expected_rows,
    CASE
        WHEN COUNT(*) = 8 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "seclend_authorized_rating";

-- Validate row count for: Seclend_Authorized_Sector
SELECT
    'seclend_authorized_sector' as table_name,
    COUNT(*) as actual_rows,
    1 as expected_rows,
    CASE
        WHEN COUNT(*) = 1 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "seclend_authorized_sector";

-- Validate row count for: Seclend_Non-Authorized_Securities
SELECT
    'seclend_non_authorized_securities' as table_name,
    COUNT(*) as actual_rows,
    1 as expected_rows,
    CASE
        WHEN COUNT(*) = 1 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "seclend_non_authorized_securities";

-- Validate row count for: Seclend_Rating_Ctry Issuer
SELECT
    'seclend_rating_ctry_issuer' as table_name,
    COUNT(*) as actual_rows,
    26 as expected_rows,
    CASE
        WHEN COUNT(*) = 26 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "seclend_rating_ctry_issuer";

-- Validate row count for: Secteurs
SELECT
    'secteurs' as table_name,
    COUNT(*) as actual_rows,
    17 as expected_rows,
    CASE
        WHEN COUNT(*) = 17 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "secteurs";

-- Validate row count for: Sector - Matching table
SELECT
    'sector___matching_table' as table_name,
    COUNT(*) as actual_rows,
    32 as expected_rows,
    CASE
        WHEN COUNT(*) = 32 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "sector___matching_table";

-- Validate row count for: Sector - Matching table - details
SELECT
    'sector___matching_table___details' as table_name,
    COUNT(*) as actual_rows,
    43 as expected_rows,
    CASE
        WHEN COUNT(*) = 43 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "sector___matching_table___details";

-- Validate row count for: Specific Limits
SELECT
    'specific_limits' as table_name,
    COUNT(*) as actual_rows,
    293 as expected_rows,
    CASE
        WHEN COUNT(*) = 293 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "specific_limits";

-- Validate row count for: Statique dashboard
SELECT
    'statique_dashboard' as table_name,
    COUNT(*) as actual_rows,
    28 as expected_rows,
    CASE
        WHEN COUNT(*) = 28 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "statique_dashboard";

-- Validate row count for: Structured Product
SELECT
    'structured_product' as table_name,
    COUNT(*) as actual_rows,
    189 as expected_rows,
    CASE
        WHEN COUNT(*) = 189 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "structured_product";

-- Validate row count for: Swing rate
SELECT
    'swing_rate' as table_name,
    COUNT(*) as actual_rows,
    6 as expected_rows,
    CASE
        WHEN COUNT(*) = 6 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "swing_rate";

-- Validate row count for: Table Countries
SELECT
    'table_countries' as table_name,
    COUNT(*) as actual_rows,
    261 as expected_rows,
    CASE
        WHEN COUNT(*) = 261 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "table_countries";

-- Validate row count for: xxx List LiqRepport - Ref Date
SELECT
    'xxx_list_liqrepport___ref_date' as table_name,
    COUNT(*) as actual_rows,
    409 as expected_rows,
    CASE
        WHEN COUNT(*) = 409 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "xxx_list_liqrepport___ref_date";

-- Validate row count for: Asset Type RNC
SELECT
    'asset_type_rnc' as table_name,
    COUNT(*) as actual_rows,
    53 as expected_rows,
    CASE
        WHEN COUNT(*) = 53 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "asset_type_rnc";

-- Validate row count for: Exception Commodities
SELECT
    'exception_commodities' as table_name,
    COUNT(*) as actual_rows,
    11 as expected_rows,
    CASE
        WHEN COUNT(*) = 11 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "exception_commodities";

-- Validate row count for: Liquidity Funds
SELECT
    'liquidity_funds' as table_name,
    COUNT(*) as actual_rows,
    238 as expected_rows,
    CASE
        WHEN COUNT(*) = 238 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "liquidity_funds";

-- Validate row count for: List_Mapping ptf
SELECT
    'list_mapping_ptf' as table_name,
    COUNT(*) as actual_rows,
    28 as expected_rows,
    CASE
        WHEN COUNT(*) = 28 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_mapping_ptf";

-- Validate row count for: List_Ratings
SELECT
    'list_ratings' as table_name,
    COUNT(*) as actual_rows,
    30 as expected_rows,
    CASE
        WHEN COUNT(*) = 30 THEN 'PASS'
        ELSE 'FAIL - Row count mismatch'
    END as status
FROM "list_ratings";


-- =====================================
-- SECTION 2: NOT NULL Constraint Validation
-- =====================================

-- Check for NULL violations: classif_country_geo.exotic
SELECT 'classif_country_geo.exotic' as column_name, COUNT(*) as null_violations
FROM "classif_country_geo"
WHERE "exotic" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: list_funds.caceis_id
SELECT 'list_funds.caceis_id' as column_name, COUNT(*) as null_violations
FROM "list_funds"
WHERE "caceis_id" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: list_param_liquidity_override.isin
SELECT 'list_param_liquidity_override.isin' as column_name, COUNT(*) as null_violations
FROM "list_param_liquidity_override"
WHERE "isin" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: list_param_liquidity_redem_freq.redem_freq
SELECT 'list_param_liquidity_redem_freq.redem_freq' as column_name, COUNT(*) as null_violations
FROM "list_param_liquidity_redem_freq"
WHERE "redem_freq" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: list_ptf_limit.caceis_id
SELECT 'list_ptf_limit.caceis_id' as column_name, COUNT(*) as null_violations
FROM "list_ptf_limit"
WHERE "caceis_id" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: list_rating_counterparties.custodian_code
SELECT 'list_rating_counterparties.custodian_code' as column_name, COUNT(*) as null_violations
FROM "list_rating_counterparties"
WHERE "custodian_code" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: list_rating_counterparties.custodian_description
SELECT 'list_rating_counterparties.custodian_description' as column_name, COUNT(*) as null_violations
FROM "list_rating_counterparties"
WHERE "custodian_description" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: list_risk_type.risk
SELECT 'list_risk_type.risk' as column_name, COUNT(*) as null_violations
FROM "list_risk_type"
WHERE "risk" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: list_srm___not_covered.tfs
SELECT 'list_srm___not_covered.tfs' as column_name, COUNT(*) as null_violations
FROM "list_srm___not_covered"
WHERE "tfs" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: table_countries.exotic
SELECT 'table_countries.exotic' as column_name, COUNT(*) as null_violations
FROM "table_countries"
WHERE "exotic" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: list_ratings.ct
SELECT 'list_ratings.ct' as column_name, COUNT(*) as null_violations
FROM "list_ratings"
WHERE "ct" IS NULL;
-- Expected: 0 violations

-- Check for NULL violations: list_ratings.lt
SELECT 'list_ratings.lt' as column_name, COUNT(*) as null_violations
FROM "list_ratings"
WHERE "lt" IS NULL;
-- Expected: 0 violations


-- =====================================
-- SECTION 3: Primary Key Uniqueness
-- =====================================

-- Check PK uniqueness: bt_comments.id
SELECT
    'bt_comments.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "bt_comments"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: comment_structured_product.id
SELECT
    'comment_structured_product.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "comment_structured_product"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: comments_dashboard.id
SELECT
    'comments_dashboard.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "comments_dashboard"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: comments_investors_breakdown.id
SELECT
    'comments_investors_breakdown.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "comments_investors_breakdown"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: comments_rnc.id
SELECT
    'comments_rnc.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "comments_rnc"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: country_ratings_table.ticker
SELECT
    'country_ratings_table.ticker' as pk_column,
    "ticker",
    COUNT(*) as duplicate_count
FROM "country_ratings_table"
GROUP BY "ticker"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: esg_mapping.id
SELECT
    'esg_mapping.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "esg_mapping"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: esg_thresholds.id
SELECT
    'esg_thresholds.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "esg_thresholds"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: funds___ref_date.compartiment
SELECT
    'funds___ref_date.compartiment' as pk_column,
    "compartiment",
    COUNT(*) as duplicate_count
FROM "funds___ref_date"
GROUP BY "compartiment"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: investors_ranking.id
SELECT
    'investors_ranking.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "investors_ranking"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: italian_opp___list_1.id
SELECT
    'italian_opp___list_1.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "italian_opp___list_1"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: italian_opp___list_2.id
SELECT
    'italian_opp___list_2.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "italian_opp___list_2"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: limit_commitment.id
SELECT
    'limit_commitment.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "limit_commitment"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: liquidity_bonds.currency
SELECT
    'liquidity_bonds.currency' as pk_column,
    "currency",
    COUNT(*) as duplicate_count
FROM "liquidity_bonds"
GROUP BY "currency"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: list_funds.caceis_id
SELECT
    'list_funds.caceis_id' as pk_column,
    "caceis_id",
    COUNT(*) as duplicate_count
FROM "list_funds"
GROUP BY "caceis_id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: list_g10_currencies.g10
SELECT
    'list_g10_currencies.g10' as pk_column,
    "g10",
    COUNT(*) as duplicate_count
FROM "list_g10_currencies"
GROUP BY "g10"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: list_param_liquidity.caceis_id
SELECT
    'list_param_liquidity.caceis_id' as pk_column,
    "caceis_id",
    COUNT(*) as duplicate_count
FROM "list_param_liquidity"
GROUP BY "caceis_id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: list_param_liquidity_bonds.currency
SELECT
    'list_param_liquidity_bonds.currency' as pk_column,
    "currency",
    COUNT(*) as duplicate_count
FROM "list_param_liquidity_bonds"
GROUP BY "currency"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: list_param_liquidity_equity.scope
SELECT
    'list_param_liquidity_equity.scope' as pk_column,
    "scope",
    COUNT(*) as duplicate_count
FROM "list_param_liquidity_equity"
GROUP BY "scope"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: list_param_liquidity_redem_freq.redem_freq
SELECT
    'list_param_liquidity_redem_freq.redem_freq' as pk_column,
    "redem_freq",
    COUNT(*) as duplicate_count
FROM "list_param_liquidity_redem_freq"
GROUP BY "redem_freq"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: list_ptf_limit.caceis_id
SELECT
    'list_ptf_limit.caceis_id' as pk_column,
    "caceis_id",
    COUNT(*) as duplicate_count
FROM "list_ptf_limit"
GROUP BY "caceis_id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: list_risk_type.num
SELECT
    'list_risk_type.num' as pk_column,
    "num",
    COUNT(*) as duplicate_count
FROM "list_risk_type"
GROUP BY "num"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: manual_input.id
SELECT
    'manual_input.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "manual_input"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: manual_input_date.id
SELECT
    'manual_input_date.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "manual_input_date"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: param_commitment.id
SELECT
    'param_commitment.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "param_commitment"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: paste_errors.f1
SELECT
    'paste_errors.f1' as pk_column,
    "f1",
    COUNT(*) as duplicate_count
FROM "paste_errors"
GROUP BY "f1"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: seclend_authorized_rating.rating
SELECT
    'seclend_authorized_rating.rating' as pk_column,
    "rating",
    COUNT(*) as duplicate_count
FROM "seclend_authorized_rating"
GROUP BY "rating"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: seclend_authorized_sector.update
SELECT
    'seclend_authorized_sector.update' as pk_column,
    "update",
    COUNT(*) as duplicate_count
FROM "seclend_authorized_sector"
GROUP BY "update"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: seclend_non_authorized_securities.update
SELECT
    'seclend_non_authorized_securities.update' as pk_column,
    "update",
    COUNT(*) as duplicate_count
FROM "seclend_non_authorized_securities"
GROUP BY "update"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: specific_limits.id
SELECT
    'specific_limits.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "specific_limits"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: statique_dashboard.id
SELECT
    'statique_dashboard.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "statique_dashboard"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: structured_product.id
SELECT
    'structured_product.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "structured_product"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: swing_rate.id
SELECT
    'swing_rate.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "swing_rate"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: asset_type_rnc.id
SELECT
    'asset_type_rnc.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "asset_type_rnc"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: list_mapping_ptf.id
SELECT
    'list_mapping_ptf.id' as pk_column,
    "id",
    COUNT(*) as duplicate_count
FROM "list_mapping_ptf"
GROUP BY "id"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)

-- Check PK uniqueness: list_ratings.sp
SELECT
    'list_ratings.sp' as pk_column,
    "sp",
    COUNT(*) as duplicate_count
FROM "list_ratings"
GROUP BY "sp"
HAVING COUNT(*) > 1;
-- Expected: No rows (all PKs should be unique)


-- =====================================
-- SECTION 4: Data Type Validation
-- =====================================

-- Check for invalid date values
SELECT 'bt_comments.date' as column_name, MIN("date") as min_date, MAX("date") as max_date FROM "bt_comments";
SELECT 'comments_dashboard.value_date' as column_name, MIN("value_date") as min_date, MAX("value_date") as max_date FROM "comments_dashboard";
SELECT 'comments_investors_breakdown.eopdate' as column_name, MIN("eopdate") as min_date, MAX("eopdate") as max_date FROM "comments_investors_breakdown";
SELECT 'comments_rnc.value_date' as column_name, MIN("value_date") as min_date, MAX("value_date") as max_date FROM "comments_rnc";
SELECT 'investors_ranking.date' as column_name, MIN("date") as min_date, MAX("date") as max_date FROM "investors_ranking";
SELECT 'list_liquidity_override.date_effet_override' as column_name, MIN("date_effet_override") as min_date, MAX("date_effet_override") as max_date FROM "list_liquidity_override";
SELECT 'list_param_liquidity_override.date_effet_override' as column_name, MIN("date_effet_override") as min_date, MAX("date_effet_override") as max_date FROM "list_param_liquidity_override";
SELECT 'list_param_liquidity_override.date_saisie' as column_name, MIN("date_saisie") as min_date, MAX("date_saisie") as max_date FROM "list_param_liquidity_override";
SELECT 'list_param_liquidity_redem_freq.date_saisie' as column_name, MIN("date_saisie") as min_date, MAX("date_saisie") as max_date FROM "list_param_liquidity_redem_freq";
SELECT 'manual_input.date_start' as column_name, MIN("date_start") as min_date, MAX("date_start") as max_date FROM "manual_input";
SELECT 'manual_input.date_end' as column_name, MIN("date_end") as min_date, MAX("date_end") as max_date FROM "manual_input";
SELECT 'manual_input_date.value_date' as column_name, MIN("value_date") as min_date, MAX("value_date") as max_date FROM "manual_input_date";
SELECT 'param_commitment.date_start' as column_name, MIN("date_start") as min_date, MAX("date_start") as max_date FROM "param_commitment";
SELECT 'param_commitment.date_end' as column_name, MIN("date_end") as min_date, MAX("date_end") as max_date FROM "param_commitment";
SELECT 'param_commitment.f12' as column_name, MIN("f12") as min_date, MAX("f12") as max_date FROM "param_commitment";
SELECT 'paste_errors.f11' as column_name, MIN("f11") as min_date, MAX("f11") as max_date FROM "paste_errors";
SELECT 'seclend_rating_ctry_issuer.date_start' as column_name, MIN("date_start") as min_date, MAX("date_start") as max_date FROM "seclend_rating_ctry_issuer";
SELECT 'seclend_rating_ctry_issuer.date_end' as column_name, MIN("date_end") as min_date, MAX("date_end") as max_date FROM "seclend_rating_ctry_issuer";
SELECT 'specific_limits.date_start' as column_name, MIN("date_start") as min_date, MAX("date_start") as max_date FROM "specific_limits";
SELECT 'specific_limits.date_end' as column_name, MIN("date_end") as min_date, MAX("date_end") as max_date FROM "specific_limits";
SELECT 'statique_dashboard.date_start' as column_name, MIN("date_start") as min_date, MAX("date_start") as max_date FROM "statique_dashboard";
SELECT 'statique_dashboard.date_end' as column_name, MIN("date_end") as min_date, MAX("date_end") as max_date FROM "statique_dashboard";
SELECT 'structured_product.dates' as column_name, MIN("dates") as min_date, MAX("dates") as max_date FROM "structured_product";

-- =====================================
-- SECTION 5: Summary Validation Report
-- =====================================

-- Generate summary of all tables
SELECT
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
