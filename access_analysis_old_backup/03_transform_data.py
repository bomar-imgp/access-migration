#!/usr/bin/env python3
"""Data transformation script for Access to PostgreSQL migration"""
# This script handles data type conversions and cleaning
# Generated: 2026-01-29 11:16:15.360887

import pandas as pd
import os
from datetime import datetime

CSV_DIR = "access_analysis/csv"
OUTPUT_DIR = "access_analysis/csv_transformed"

os.makedirs(OUTPUT_DIR, exist_ok=True)

def transform_table(filename, transformations):
    df = pd.read_csv(os.path.join(CSV_DIR, filename))
    # Apply transformations
    for col, transform in transformations.items():
        if col in df.columns:
            if transform == 'datetime':
                df[col] = pd.to_datetime(df[col], errors='coerce')
            elif transform == 'boolean':
                df[col] = df[col].map({'Yes': True, 'No': False, '1': True, '0': False})
    df.to_csv(os.path.join(OUTPUT_DIR, filename), index=False)
    print(f'Transformed {filename}')

# Table-specific transformations
# Add your transformations here

print('Transformation complete!')
