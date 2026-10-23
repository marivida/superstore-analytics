# Data Quality Assessment

## 1. Purpose

This document describes the data quality checks performed during the development of the Superstore Analytics project, the issues identified, and the decisions made to prepare the data for analytical use.

## 2. Source Data Import

The initial CSV import resulted in incorrect numeric conversions for some fields.

To address this issue, the source data was reimported into `stg.SuperstoreRaw_Text`, storing the original values as text. Explicit data type conversions were then performed to create `stg.Superstore_Clean`.

This approach allowed the data to be validated before loading it into the dimensional model.

## 3. Data Validation Checks

The following checks were performed:

- Verified the total number of records in the cleaned dataset.
- Validated sales, quantity, discount, and profit values.
- Checked the minimum and maximum discount values.
- Verified customer identifier consistency.
- Investigated product identifiers associated with multiple product names.
- Validated geographic combinations.
- Checked whether fact records matched their corresponding dimension records.
- Compared aggregate values between the cleaned staging table and the fact table.

## 4. Product Identifier Issue

The source data contains product identifiers associated with more than one product name.

The investigation identified:

- 1,862 distinct product identifiers.
- 1,894 distinct product ID and product name combinations.

### Modeling Decision

The product dimension uses the combination of `Product_ID` and `Product_Name` to identify distinct source product records.

This decision preserves the different product names present in the source data instead of incorrectly merging them into a single product record.

## 5. Referential Integrity

Before loading the fact table, the source records were matched against the customer, product, geography, order date, and shipping date dimensions.

The validation returned 9,994 source records and zero unmatched records across the required dimension lookups.

## 6. Reconciliation Results

The following metrics were compared between `stg.Superstore_Clean` and `fact.FactSales`.

| Metric | Validated Result |
|---|---:|
| Record count | 9,994 |
| Distinct orders | 5,009 |
| Total sales | 2,297,200.867 |
| Total quantity | 37,873 |
| Total profit | 286,397.162 |

All listed aggregate values matched between the cleaned staging data and the fact table.

## 7. Conclusion

The validation process confirmed that the fact table preserved the key aggregate values from the cleaned staging dataset.

The checks also helped identify an import issue and a product identifier inconsistency that needed to be considered during data modeling.

Further validation can be added as the ETL process becomes more automated and the Power BI report is developed.