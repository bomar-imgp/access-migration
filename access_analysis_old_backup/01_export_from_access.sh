#!/bin/bash
# Export all tables from Access to CSV
# Generated: 2026-01-29 11:16:15.360684

# Create CSV output directory
mkdir -p "access_analysis/csv"

echo 'Starting Access database export...'

# Export: BT Comments
echo "Exporting BT Comments..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "BT Comments" > "access_analysis/csv/bt_comments.csv"
echo "  -> 37 rows"

# Export: CLASSIF_COUNTRY_GEO
echo "Exporting CLASSIF_COUNTRY_GEO..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "CLASSIF_COUNTRY_GEO" > "access_analysis/csv/classif_country_geo.csv"
echo "  -> 257 rows"

# Export: Comment Structured product
echo "Exporting Comment Structured product..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Comment Structured product" > "access_analysis/csv/comment_structured_product.csv"
echo "  -> 3 rows"

# Export: Comments Dashboard
echo "Exporting Comments Dashboard..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Comments Dashboard" > "access_analysis/csv/comments_dashboard.csv"
echo "  -> 29 rows"

# Export: Comments Investors Breakdown
echo "Exporting Comments Investors Breakdown..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Comments Investors Breakdown" > "access_analysis/csv/comments_investors_breakdown.csv"
echo "  -> 270 rows"

# Export: Comments RnC
echo "Exporting Comments RnC..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Comments RnC" > "access_analysis/csv/comments_rnc.csv"
echo "  -> 87 rows"

# Export: Copy Of Fichier_Finalyse
echo "Exporting Copy Of Fichier_Finalyse..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Copy Of Fichier_Finalyse" > "access_analysis/csv/copy_of_fichier_finalyse.csv"
echo "  -> 196 rows"

# Export: Country ratings table
echo "Exporting Country ratings table..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Country ratings table" > "access_analysis/csv/country_ratings_table.csv"
echo "  -> 199 rows"

# Export: ESG MAPPING
echo "Exporting ESG MAPPING..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "ESG MAPPING" > "access_analysis/csv/esg_mapping.csv"
echo "  -> 19 rows"

# Export: ESG Thresholds
echo "Exporting ESG Thresholds..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "ESG Thresholds" > "access_analysis/csv/esg_thresholds.csv"
echo "  -> 28 rows"

# Export: Fichier_Finalyse
echo "Exporting Fichier_Finalyse..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Fichier_Finalyse" > "access_analysis/csv/fichier_finalyse.csv"
echo "  -> 160 rows"

# Export: Funds - Ref Date
echo "Exporting Funds - Ref Date..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Funds - Ref Date" > "access_analysis/csv/funds___ref_date.csv"
echo "  -> 32 rows"

# Export: Investors Ranking
echo "Exporting Investors Ranking..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Investors Ranking" > "access_analysis/csv/investors_ranking.csv"
echo "  -> 70 rows"

# Export: Italian Opp - LIST 1
echo "Exporting Italian Opp - LIST 1..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Italian Opp - LIST 1" > "access_analysis/csv/italian_opp___list_1.csv"
echo "  -> 58 rows"

# Export: Italian Opp - LIST 2
echo "Exporting Italian Opp - LIST 2..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Italian Opp - LIST 2" > "access_analysis/csv/italian_opp___list_2.csv"
echo "  -> 78 rows"

# Export: Limit Commitment
echo "Exporting Limit Commitment..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Limit Commitment" > "access_analysis/csv/limit_commitment.csv"
echo "  -> 28 rows"

# Export: Liquidity bonds
echo "Exporting Liquidity bonds..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Liquidity bonds" > "access_analysis/csv/liquidity_bonds.csv"
echo "  -> 5 rows"

# Export: LIST FUNDS
echo "Exporting LIST FUNDS..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "LIST FUNDS" > "access_analysis/csv/list_funds.csv"
echo "  -> 28 rows"

# Export: List LiqRepport - Ref Date
echo "Exporting List LiqRepport - Ref Date..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "List LiqRepport - Ref Date" > "access_analysis/csv/list_liqrepport___ref_date.csv"
echo "  -> 257 rows"

# Export: List LiqRepport - Ref Date agg
echo "Exporting List LiqRepport - Ref Date agg..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "List LiqRepport - Ref Date agg" > "access_analysis/csv/list_liqrepport___ref_date_agg.csv"
echo "  -> 25 rows"

# Export: List_Exception Table
echo "Exporting List_Exception Table..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "List_Exception Table" > "access_analysis/csv/list_exception_table.csv"
echo "  -> 13 rows"

# Export: LIST_G10_CURRENCIES
echo "Exporting LIST_G10_CURRENCIES..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "LIST_G10_CURRENCIES" > "access_analysis/csv/list_g10_currencies.csv"
echo "  -> 10 rows"

# Export: List_Liquidity Override
echo "Exporting List_Liquidity Override..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "List_Liquidity Override" > "access_analysis/csv/list_liquidity_override.csv"
echo "  -> 0 rows"

# Export: LIST_param_Liquidity
echo "Exporting LIST_param_Liquidity..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "LIST_param_Liquidity" > "access_analysis/csv/list_param_liquidity.csv"
echo "  -> 27 rows"

# Export: LIST_param_Liquidity_Bonds
echo "Exporting LIST_param_Liquidity_Bonds..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "LIST_param_Liquidity_Bonds" > "access_analysis/csv/list_param_liquidity_bonds.csv"
echo "  -> 5 rows"

# Export: LIST_param_Liquidity_Equity
echo "Exporting LIST_param_Liquidity_Equity..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "LIST_param_Liquidity_Equity" > "access_analysis/csv/list_param_liquidity_equity.csv"
echo "  -> 1 rows"

# Export: LIST_param_Liquidity_Override
echo "Exporting LIST_param_Liquidity_Override..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "LIST_param_Liquidity_Override" > "access_analysis/csv/list_param_liquidity_override.csv"
echo "  -> 263 rows"

# Export: LIST_param_Liquidity_Redem_Freq
echo "Exporting LIST_param_Liquidity_Redem_Freq..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "LIST_param_Liquidity_Redem_Freq" > "access_analysis/csv/list_param_liquidity_redem_freq.csv"
echo "  -> 12 rows"

# Export: List_Ptf_Limit
echo "Exporting List_Ptf_Limit..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "List_Ptf_Limit" > "access_analysis/csv/list_ptf_limit.csv"
echo "  -> 19 rows"

# Export: List_Rating_Counterparties
echo "Exporting List_Rating_Counterparties..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "List_Rating_Counterparties" > "access_analysis/csv/list_rating_counterparties.csv"
echo "  -> 14 rows"

# Export: List_Risk_Type
echo "Exporting List_Risk_Type..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "List_Risk_Type" > "access_analysis/csv/list_risk_type.csv"
echo "  -> 6 rows"

# Export: LIST_SRM - Not Covered
echo "Exporting LIST_SRM - Not Covered..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "LIST_SRM - Not Covered" > "access_analysis/csv/list_srm___not_covered.csv"
echo "  -> 148 rows"

# Export: Manual Input
echo "Exporting Manual Input..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Manual Input" > "access_analysis/csv/manual_input.csv"
echo "  -> 5 rows"

# Export: Manual Input Date
echo "Exporting Manual Input Date..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Manual Input Date" > "access_analysis/csv/manual_input_date.csv"
echo "  -> 36 rows"

# Export: Param Commitment
echo "Exporting Param Commitment..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Param Commitment" > "access_analysis/csv/param_commitment.csv"
echo "  -> 19 rows"

# Export: Paste Errors
echo "Exporting Paste Errors..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Paste Errors" > "access_analysis/csv/paste_errors.csv"
echo "  -> 1 rows"

# Export: Seclend_Authorized_Countries
echo "Exporting Seclend_Authorized_Countries..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Seclend_Authorized_Countries" > "access_analysis/csv/seclend_authorized_countries.csv"
echo "  -> 37 rows"

# Export: Seclend_Authorized_Index
echo "Exporting Seclend_Authorized_Index..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Seclend_Authorized_Index" > "access_analysis/csv/seclend_authorized_index.csv"
echo "  -> 22 rows"

# Export: Seclend_Authorized_Rating
echo "Exporting Seclend_Authorized_Rating..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Seclend_Authorized_Rating" > "access_analysis/csv/seclend_authorized_rating.csv"
echo "  -> 8 rows"

# Export: Seclend_Authorized_Sector
echo "Exporting Seclend_Authorized_Sector..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Seclend_Authorized_Sector" > "access_analysis/csv/seclend_authorized_sector.csv"
echo "  -> 1 rows"

# Export: Seclend_Non-Authorized_Securities
echo "Exporting Seclend_Non-Authorized_Securities..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Seclend_Non-Authorized_Securities" > "access_analysis/csv/seclend_non_authorized_securities.csv"
echo "  -> 1 rows"

# Export: Seclend_Rating_Ctry Issuer
echo "Exporting Seclend_Rating_Ctry Issuer..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Seclend_Rating_Ctry Issuer" > "access_analysis/csv/seclend_rating_ctry_issuer.csv"
echo "  -> 26 rows"

# Export: Secteurs
echo "Exporting Secteurs..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Secteurs" > "access_analysis/csv/secteurs.csv"
echo "  -> 17 rows"

# Export: Sector - Matching table
echo "Exporting Sector - Matching table..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Sector - Matching table" > "access_analysis/csv/sector___matching_table.csv"
echo "  -> 32 rows"

# Export: Sector - Matching table - details
echo "Exporting Sector - Matching table - details..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Sector - Matching table - details" > "access_analysis/csv/sector___matching_table___details.csv"
echo "  -> 43 rows"

# Export: Specific Limits
echo "Exporting Specific Limits..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Specific Limits" > "access_analysis/csv/specific_limits.csv"
echo "  -> 293 rows"

# Export: Statique dashboard
echo "Exporting Statique dashboard..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Statique dashboard" > "access_analysis/csv/statique_dashboard.csv"
echo "  -> 28 rows"

# Export: Structured Product
echo "Exporting Structured Product..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Structured Product" > "access_analysis/csv/structured_product.csv"
echo "  -> 189 rows"

# Export: Swing rate
echo "Exporting Swing rate..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Swing rate" > "access_analysis/csv/swing_rate.csv"
echo "  -> 6 rows"

# Export: Table Countries
echo "Exporting Table Countries..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Table Countries" > "access_analysis/csv/table_countries.csv"
echo "  -> 261 rows"

# Export: xxx List LiqRepport - Ref Date
echo "Exporting xxx List LiqRepport - Ref Date..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "xxx List LiqRepport - Ref Date" > "access_analysis/csv/xxx_list_liqrepport___ref_date.csv"
echo "  -> 409 rows"

# Export: Asset Type RNC
echo "Exporting Asset Type RNC..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Asset Type RNC" > "access_analysis/csv/asset_type_rnc.csv"
echo "  -> 53 rows"

# Export: Exception Commodities
echo "Exporting Exception Commodities..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Exception Commodities" > "access_analysis/csv/exception_commodities.csv"
echo "  -> 11 rows"

# Export: Liquidity Funds
echo "Exporting Liquidity Funds..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "Liquidity Funds" > "access_analysis/csv/liquidity_funds.csv"
echo "  -> 238 rows"

# Export: List_Mapping ptf
echo "Exporting List_Mapping ptf..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "List_Mapping ptf" > "access_analysis/csv/list_mapping_ptf.csv"
echo "  -> 28 rows"

# Export: List_Ratings
echo "Exporting List_Ratings..."
mdb-export "/home/bomar-ubu-1/migration-access/risk.mdb" "List_Ratings" > "access_analysis/csv/list_ratings.csv"
echo "  -> 30 rows"

echo "Export complete!"
