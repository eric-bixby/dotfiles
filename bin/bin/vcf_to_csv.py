#!/usr/bin/env python3

import os
import csv
import re
from pathlib import Path

def parse_vcf_file(filepath):
    """Parse a single VCF file and extract contact information."""
    contacts = []
    current_contact = {}

    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()

    for line in lines:
        line = line.strip()

        if line.startswith('BEGIN:VCARD'):
            current_contact = {}

        elif line.startswith('END:VCARD'):
            if current_contact:
                contacts.append(current_contact)
            current_contact = {}

        elif line.startswith('FN:'):
            current_contact['Name'] = line[3:]

        elif line.startswith('N:'):
            # Format: Family;Given;Middle;Prefix;Suffix
            parts = line[2:].split(';')
            if len(parts) >= 2:
                current_contact['Given Name'] = parts[1] if len(parts) > 1 else ''
                current_contact['Family Name'] = parts[0] if len(parts) > 0 else ''

        elif line.startswith('EMAIL'):
            email = line.split(':', 1)[1] if ':' in line else ''
            if 'Email 1 - Value' not in current_contact:
                current_contact['Email 1 - Value'] = email
            elif 'Email 2 - Value' not in current_contact:
                current_contact['Email 2 - Value'] = email

        elif line.startswith('TEL'):
            phone = line.split(':', 1)[1] if ':' in line else ''
            # Determine phone type
            if 'CELL' in line.upper() or 'MOBILE' in line.upper():
                if 'Phone 1 - Value' not in current_contact:
                    current_contact['Phone 1 - Type'] = 'Mobile'
                    current_contact['Phone 1 - Value'] = phone
            elif 'HOME' in line.upper():
                if 'Phone 2 - Value' not in current_contact:
                    current_contact['Phone 2 - Type'] = 'Home'
                    current_contact['Phone 2 - Value'] = phone
            elif 'WORK' in line.upper():
                if 'Phone 3 - Value' not in current_contact:
                    current_contact['Phone 3 - Type'] = 'Work'
                    current_contact['Phone 3 - Value'] = phone
            else:
                if 'Phone 1 - Value' not in current_contact:
                    current_contact['Phone 1 - Type'] = 'Mobile'
                    current_contact['Phone 1 - Value'] = phone

        elif line.startswith('ORG:'):
            current_contact['Organization 1 - Name'] = line[4:]

        elif line.startswith('TITLE:'):
            current_contact['Organization 1 - Title'] = line[6:]

        elif line.startswith('ADR'):
            # Format: ;;Street;City;State;Postal;Country
            addr = line.split(':', 1)[1] if ':' in line else ''
            parts = addr.split(';')
            if 'HOME' in line.upper():
                prefix = 'Address 1'
            elif 'WORK' in line.upper():
                prefix = 'Address 2'
            else:
                prefix = 'Address 1'

            if len(parts) > 2:
                current_contact[f'{prefix} - Street'] = parts[2]
            if len(parts) > 3:
                current_contact[f'{prefix} - City'] = parts[3]
            if len(parts) > 4:
                current_contact[f'{prefix} - Region'] = parts[4]
            if len(parts) > 5:
                current_contact[f'{prefix} - Postal Code'] = parts[5]
            if len(parts) > 6:
                current_contact[f'{prefix} - Country'] = parts[6]

        elif line.startswith('NOTE:'):
            current_contact['Notes'] = line[5:]

        elif line.startswith('URL:'):
            current_contact['Website 1 - Value'] = line[4:]

        elif line.startswith('BDAY:'):
            birthday = line[5:]
            # Try to parse YYYYMMDD format
            if len(birthday) == 8:
                current_contact['Birthday'] = f"{birthday[0:4]}-{birthday[4:6]}-{birthday[6:8]}"
            else:
                current_contact['Birthday'] = birthday

    return contacts

def main():
    # Find all VCF files in current directory
    vcf_files = list(Path('.').glob('*.vcf'))

    if not vcf_files:
        print("No .vcf files found in the current directory.")
        return

    print(f"Found {len(vcf_files)} VCF file(s)")

    # Collect all contacts
    all_contacts = []
    for vcf_file in vcf_files:
        print(f"Processing: {vcf_file}")
        contacts = parse_vcf_file(vcf_file)
        all_contacts.extend(contacts)

    print(f"Extracted {len(all_contacts)} contact(s)")

    # Google Contacts CSV headers
    headers = [
        'Name', 'Given Name', 'Additional Name', 'Family Name', 'Yomi Name',
        'Given Name Yomi', 'Additional Name Yomi', 'Family Name Yomi', 'Name Prefix',
        'Name Suffix', 'Initials', 'Nickname', 'Short Name', 'Maiden Name',
        'Birthday', 'Gender', 'Location', 'Billing Information', 'Directory Server',
        'Mileage', 'Occupation', 'Hobby', 'Sensitivity', 'Priority', 'Subject',
        'Notes', 'Language', 'Photo', 'Group Membership', 'E-mail 1 - Type',
        'E-mail 1 - Value', 'E-mail 2 - Type', 'E-mail 2 - Value', 'Phone 1 - Type',
        'Phone 1 - Value', 'Phone 2 - Type', 'Phone 2 - Value', 'Phone 3 - Type',
        'Phone 3 - Value', 'Address 1 - Type', 'Address 1 - Formatted',
        'Address 1 - Street', 'Address 1 - City', 'Address 1 - PO Box',
        'Address 1 - Region', 'Address 1 - Postal Code', 'Address 1 - Country',
        'Address 1 - Extended Address', 'Address 2 - Type', 'Address 2 - Formatted',
        'Address 2 - Street', 'Address 2 - City', 'Address 2 - PO Box',
        'Address 2 - Region', 'Address 2 - Postal Code', 'Address 2 - Country',
        'Address 2 - Extended Address', 'Organization 1 - Type', 'Organization 1 - Name',
        'Organization 1 - Yomi Name', 'Organization 1 - Title', 'Organization 1 - Department',
        'Organization 1 - Symbol', 'Organization 1 - Location', 'Organization 1 - Job Description',
        'Website 1 - Type', 'Website 1 - Value'
    ]

    # Write to CSV
    output_file = 'google_contacts.csv'
    with open(output_file, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=headers, extrasaction='ignore')
        writer.writeheader()

        for contact in all_contacts:
            # Set default email types
            if 'Email 1 - Value' in contact and 'Email 1 - Type' not in contact:
                contact['E-mail 1 - Type'] = '* Home'
                contact['E-mail 1 - Value'] = contact.pop('Email 1 - Value')
            if 'Email 2 - Value' in contact and 'Email 2 - Type' not in contact:
                contact['E-mail 2 - Type'] = 'Work'
                contact['E-mail 2 - Value'] = contact.pop('Email 2 - Value')

            writer.writerow(contact)

    print(f"\nSuccessfully created {output_file} with {len(all_contacts)} contact(s)")

if __name__ == '__main__':
    main()

