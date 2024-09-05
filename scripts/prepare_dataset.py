import datasets
import json

# This is the code from lm-evaluation-harness result file.
# In order to reduce the bias, I choose this prompt when performing finetuing.
def doc_to_text(doc) -> str:
    """
    Question: <question>
    Choices:
    A. <choice1>
    B. <choice2>
    C. <choice3>
    D. <choice4>
    Answer:
    """
    choices = [doc["opa"], doc["opb"], doc["opc"], doc["opd"]]
    option_choices = {
        "A": choices[0],
        "B": choices[1],
        "C": choices[2],
        "D": choices[3],
    }

    prompt = "Question: " + doc["question"] + "\nChoices:\n"
    for choice, option in option_choices.items():
        prompt += f"{choice.upper()}. {option}\n"
    prompt += "Answer:"
    return prompt

if __name__=="__main__":
    dataset = datasets.load_dataset("openlifescienceai/medmcqa")["train"]
    reformed_dataset = []
    answer = [" A", " B", " C", " D"]
    
    for d in dataset:
        # Alphaca format
        reformed_dataset.append({
            "instruction": doc_to_text(d),
            "input": "",
            "output": answer[d["cop"]]
        })
        
    with open("data/medmcqa_alpaca_format.jsonl", "w") as f:
        for d in reformed_dataset:
            json.dump(d, f)
            f.write("\n")
            
    print("Dataset has been saved in data/medmcqa_alpaca_format.jsonl")