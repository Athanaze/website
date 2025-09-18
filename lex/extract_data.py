"""
(venv) [s@qr explore_questions_juridiques_traitees]$ python extract_data.py 
Loading dataset 'liechtconsulting/analysed_court_rulings'...
Generating train split: 100%|████████████████████████████████| 9846/9846 [00:04<00:00, 1990.02 examples/s]
Dataset loaded successfully.
Original number of questions (including non-strings): 44952
Successfully filtered for string instances and converted to lowercase.
Number of unique questions: 40680
Reduction in size (based on string items): 9.50%

"""

import json
from datasets import load_dataset
import sys

# Increase the CSV field size limit to handle large fields in the dataset
import csv
csv.field_size_limit(sys.maxsize)

print("Loading dataset 'liechtconsulting/analysed_court_rulings'...")
# Load the dataset from Hugging Face using the 'csv' type and specifying the delimiter
try:
    dataset = load_dataset("liechticonsulting/analysed_court_rulings", "default", delimiter=",", split='train')
    print("Dataset loaded successfully.")
except Exception as e:
    print(f"Failed to load dataset: {e}")
    exit()


# Extract "questions_juridiques_traitees" from each row
all_questions = []
for item in dataset:
    # The 'analysis_json' is in a column that might have a different name if not default, check item keys.
    # Assuming the column name is 'analysis_json' as per the initial view.
    if 'analysis_json' not in item or not isinstance(item['analysis_json'], str):
        continue

    try:
        # Load the JSON data from the string
        analysis = json.loads(item['analysis_json'])
        
        # Check if the key exists and is a list
        if 'questions_juridiques_traitees' in analysis and isinstance(analysis['questions_juridiques_traitees'], list):
            all_questions.extend(analysis['questions_juridiques_traitees'])

    except (json.JSONDecodeError, TypeError):
        # Handle cases where analysis_json is not a valid JSON string
        continue

# Calculate the cardinality of the original list
original_cardinality = len(all_questions)
print(f"Original number of questions (including non-strings): {original_cardinality}")

# Convert to a set of lowercase strings to remove duplicates, ADDING A TYPE CHECK
unique_questions = set(question.lower() for question in all_questions if isinstance(question, str))
print("Successfully filtered for string instances and converted to lowercase.")

# Calculate the cardinality of the set
set_cardinality = len(unique_questions)
print(f"Number of unique questions: {set_cardinality}")

# Calculate the percentage reduction
if original_cardinality > 0:
    # We should calculate reduction based on the number of actual strings found
    string_questions_count = sum(1 for q in all_questions if isinstance(q, str))
    reduction_percentage = ((string_questions_count - set_cardinality) / string_questions_count) * 100 if string_questions_count > 0 else 0
    print(f"Reduction in size (based on string items): {reduction_percentage:.2f}%")
else:
    print("No questions found.")

# Save the set as a JSON file
with open('questions.json', 'w', encoding='utf-8') as f:
    json.dump(list(unique_questions), f, ensure_ascii=False, indent=2)

print("\nSuccessfully saved the unique questions to questions.json")