-- Import CSV files to PostgreSQL
-- Generated: 2026-01-29 11:16:15.360790
-- Run this script as PostgreSQL superuser

-- Disable triggers during import for performance
SET session_replication_role = 'replica';

-- Import: BT Comments -> bt_comments
\echo 'Importing bt_comments...'
\COPY "bt_comments" FROM 'access_analysis/csv/bt_comments.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: CLASSIF_COUNTRY_GEO -> classif_country_geo
\echo 'Importing classif_country_geo...'
\COPY "classif_country_geo" FROM 'access_analysis/csv/classif_country_geo.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Comment Structured product -> comment_structured_product
\echo 'Importing comment_structured_product...'
\COPY "comment_structured_product" FROM 'access_analysis/csv/comment_structured_product.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Comments Dashboard -> comments_dashboard
\echo 'Importing comments_dashboard...'
\COPY "comments_dashboard" FROM 'access_analysis/csv/comments_dashboard.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Comments Investors Breakdown -> comments_investors_breakdown
\echo 'Importing comments_investors_breakdown...'
\COPY "comments_investors_breakdown" FROM 'access_analysis/csv/comments_investors_breakdown.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Comments RnC -> comments_rnc
\echo 'Importing comments_rnc...'
\COPY "comments_rnc" FROM 'access_analysis/csv/comments_rnc.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Copy Of Fichier_Finalyse -> copy_of_fichier_finalyse
\echo 'Importing copy_of_fichier_finalyse...'
\COPY "copy_of_fichier_finalyse" FROM 'access_analysis/csv/copy_of_fichier_finalyse.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Country ratings table -> country_ratings_table
\echo 'Importing country_ratings_table...'
\COPY "country_ratings_table" FROM 'access_analysis/csv/country_ratings_table.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: ESG MAPPING -> esg_mapping
\echo 'Importing esg_mapping...'
\COPY "esg_mapping" FROM 'access_analysis/csv/esg_mapping.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: ESG Thresholds -> esg_thresholds
\echo 'Importing esg_thresholds...'
\COPY "esg_thresholds" FROM 'access_analysis/csv/esg_thresholds.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Fichier_Finalyse -> fichier_finalyse
\echo 'Importing fichier_finalyse...'
\COPY "fichier_finalyse" FROM 'access_analysis/csv/fichier_finalyse.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Funds - Ref Date -> funds___ref_date
\echo 'Importing funds___ref_date...'
\COPY "funds___ref_date" FROM 'access_analysis/csv/funds___ref_date.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Investors Ranking -> investors_ranking
\echo 'Importing investors_ranking...'
\COPY "investors_ranking" FROM 'access_analysis/csv/investors_ranking.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Italian Opp - LIST 1 -> italian_opp___list_1
\echo 'Importing italian_opp___list_1...'
\COPY "italian_opp___list_1" FROM 'access_analysis/csv/italian_opp___list_1.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Italian Opp - LIST 2 -> italian_opp___list_2
\echo 'Importing italian_opp___list_2...'
\COPY "italian_opp___list_2" FROM 'access_analysis/csv/italian_opp___list_2.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Limit Commitment -> limit_commitment
\echo 'Importing limit_commitment...'
\COPY "limit_commitment" FROM 'access_analysis/csv/limit_commitment.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Liquidity bonds -> liquidity_bonds
\echo 'Importing liquidity_bonds...'
\COPY "liquidity_bonds" FROM 'access_analysis/csv/liquidity_bonds.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: LIST FUNDS -> list_funds
\echo 'Importing list_funds...'
\COPY "list_funds" FROM 'access_analysis/csv/list_funds.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: List LiqRepport - Ref Date -> list_liqrepport___ref_date
\echo 'Importing list_liqrepport___ref_date...'
\COPY "list_liqrepport___ref_date" FROM 'access_analysis/csv/list_liqrepport___ref_date.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: List LiqRepport - Ref Date agg -> list_liqrepport___ref_date_agg
\echo 'Importing list_liqrepport___ref_date_agg...'
\COPY "list_liqrepport___ref_date_agg" FROM 'access_analysis/csv/list_liqrepport___ref_date_agg.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: List_Exception Table -> list_exception_table
\echo 'Importing list_exception_table...'
\COPY "list_exception_table" FROM 'access_analysis/csv/list_exception_table.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: LIST_G10_CURRENCIES -> list_g10_currencies
\echo 'Importing list_g10_currencies...'
\COPY "list_g10_currencies" FROM 'access_analysis/csv/list_g10_currencies.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: List_Liquidity Override -> list_liquidity_override
\echo 'Importing list_liquidity_override...'
\COPY "list_liquidity_override" FROM 'access_analysis/csv/list_liquidity_override.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: LIST_param_Liquidity -> list_param_liquidity
\echo 'Importing list_param_liquidity...'
\COPY "list_param_liquidity" FROM 'access_analysis/csv/list_param_liquidity.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: LIST_param_Liquidity_Bonds -> list_param_liquidity_bonds
\echo 'Importing list_param_liquidity_bonds...'
\COPY "list_param_liquidity_bonds" FROM 'access_analysis/csv/list_param_liquidity_bonds.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: LIST_param_Liquidity_Equity -> list_param_liquidity_equity
\echo 'Importing list_param_liquidity_equity...'
\COPY "list_param_liquidity_equity" FROM 'access_analysis/csv/list_param_liquidity_equity.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: LIST_param_Liquidity_Override -> list_param_liquidity_override
\echo 'Importing list_param_liquidity_override...'
\COPY "list_param_liquidity_override" FROM 'access_analysis/csv/list_param_liquidity_override.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: LIST_param_Liquidity_Redem_Freq -> list_param_liquidity_redem_freq
\echo 'Importing list_param_liquidity_redem_freq...'
\COPY "list_param_liquidity_redem_freq" FROM 'access_analysis/csv/list_param_liquidity_redem_freq.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: List_Ptf_Limit -> list_ptf_limit
\echo 'Importing list_ptf_limit...'
\COPY "list_ptf_limit" FROM 'access_analysis/csv/list_ptf_limit.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: List_Rating_Counterparties -> list_rating_counterparties
\echo 'Importing list_rating_counterparties...'
\COPY "list_rating_counterparties" FROM 'access_analysis/csv/list_rating_counterparties.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: List_Risk_Type -> list_risk_type
\echo 'Importing list_risk_type...'
\COPY "list_risk_type" FROM 'access_analysis/csv/list_risk_type.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: LIST_SRM - Not Covered -> list_srm___not_covered
\echo 'Importing list_srm___not_covered...'
\COPY "list_srm___not_covered" FROM 'access_analysis/csv/list_srm___not_covered.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Manual Input -> manual_input
\echo 'Importing manual_input...'
\COPY "manual_input" FROM 'access_analysis/csv/manual_input.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Manual Input Date -> manual_input_date
\echo 'Importing manual_input_date...'
\COPY "manual_input_date" FROM 'access_analysis/csv/manual_input_date.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Param Commitment -> param_commitment
\echo 'Importing param_commitment...'
\COPY "param_commitment" FROM 'access_analysis/csv/param_commitment.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Paste Errors -> paste_errors
\echo 'Importing paste_errors...'
\COPY "paste_errors" FROM 'access_analysis/csv/paste_errors.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Seclend_Authorized_Countries -> seclend_authorized_countries
\echo 'Importing seclend_authorized_countries...'
\COPY "seclend_authorized_countries" FROM 'access_analysis/csv/seclend_authorized_countries.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Seclend_Authorized_Index -> seclend_authorized_index
\echo 'Importing seclend_authorized_index...'
\COPY "seclend_authorized_index" FROM 'access_analysis/csv/seclend_authorized_index.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Seclend_Authorized_Rating -> seclend_authorized_rating
\echo 'Importing seclend_authorized_rating...'
\COPY "seclend_authorized_rating" FROM 'access_analysis/csv/seclend_authorized_rating.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Seclend_Authorized_Sector -> seclend_authorized_sector
\echo 'Importing seclend_authorized_sector...'
\COPY "seclend_authorized_sector" FROM 'access_analysis/csv/seclend_authorized_sector.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Seclend_Non-Authorized_Securities -> seclend_non_authorized_securities
\echo 'Importing seclend_non_authorized_securities...'
\COPY "seclend_non_authorized_securities" FROM 'access_analysis/csv/seclend_non_authorized_securities.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Seclend_Rating_Ctry Issuer -> seclend_rating_ctry_issuer
\echo 'Importing seclend_rating_ctry_issuer...'
\COPY "seclend_rating_ctry_issuer" FROM 'access_analysis/csv/seclend_rating_ctry_issuer.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Secteurs -> secteurs
\echo 'Importing secteurs...'
\COPY "secteurs" FROM 'access_analysis/csv/secteurs.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Sector - Matching table -> sector___matching_table
\echo 'Importing sector___matching_table...'
\COPY "sector___matching_table" FROM 'access_analysis/csv/sector___matching_table.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Sector - Matching table - details -> sector___matching_table___details
\echo 'Importing sector___matching_table___details...'
\COPY "sector___matching_table___details" FROM 'access_analysis/csv/sector___matching_table___details.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Specific Limits -> specific_limits
\echo 'Importing specific_limits...'
\COPY "specific_limits" FROM 'access_analysis/csv/specific_limits.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Statique dashboard -> statique_dashboard
\echo 'Importing statique_dashboard...'
\COPY "statique_dashboard" FROM 'access_analysis/csv/statique_dashboard.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Structured Product -> structured_product
\echo 'Importing structured_product...'
\COPY "structured_product" FROM 'access_analysis/csv/structured_product.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Swing rate -> swing_rate
\echo 'Importing swing_rate...'
\COPY "swing_rate" FROM 'access_analysis/csv/swing_rate.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Table Countries -> table_countries
\echo 'Importing table_countries...'
\COPY "table_countries" FROM 'access_analysis/csv/table_countries.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: xxx List LiqRepport - Ref Date -> xxx_list_liqrepport___ref_date
\echo 'Importing xxx_list_liqrepport___ref_date...'
\COPY "xxx_list_liqrepport___ref_date" FROM 'access_analysis/csv/xxx_list_liqrepport___ref_date.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Asset Type RNC -> asset_type_rnc
\echo 'Importing asset_type_rnc...'
\COPY "asset_type_rnc" FROM 'access_analysis/csv/asset_type_rnc.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Exception Commodities -> exception_commodities
\echo 'Importing exception_commodities...'
\COPY "exception_commodities" FROM 'access_analysis/csv/exception_commodities.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: Liquidity Funds -> liquidity_funds
\echo 'Importing liquidity_funds...'
\COPY "liquidity_funds" FROM 'access_analysis/csv/liquidity_funds.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: List_Mapping ptf -> list_mapping_ptf
\echo 'Importing list_mapping_ptf...'
\COPY "list_mapping_ptf" FROM 'access_analysis/csv/list_mapping_ptf.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Import: List_Ratings -> list_ratings
\echo 'Importing list_ratings...'
\COPY "list_ratings" FROM 'access_analysis/csv/list_ratings.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', NULL '');

-- Re-enable triggers
SET session_replication_role = 'origin';

-- Update sequences for tables with auto-increment IDs

\echo 'Import complete!'
