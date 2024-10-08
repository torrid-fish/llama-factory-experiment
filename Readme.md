# Llama-Factory Experiment

## Experiment result on medmcqa

We can see that round 1 epoch, Lora reaches its highest performance. It outperforms baseline around 3%.

![](./imgs/acc_lora_vs_dora.png)

![](./imgs/loss_lora_vs_dora.png)

## Dataset
This time I choose [medmcqa](https://medmcqa.github.io/), which is a multi-choice task on medical knowledge. 

## Install model
Follow the instruction written in [the offical github website of Llama Models](https://github.com/meta-llama/llama-models?tab=readme-ov-file#download):

> 1. Visit the [Meta Llama website](https://llama.meta.com/llama-downloads/).
> 
> 2. Read and accept the license.
> 
> 3. Once your request is approved you will receive a signed URL via email.
> 
> 4. Install the Llama CLI: `pip install llama-toolchain`.
>
> 5. Run `llama model list` to show the latest available models and determine the model ID you wish to download. NOTE: If you want older versions of models, run `llama model list --show-all` to show all the available Llama models.
>
> 6. Run: `llama download --source meta --model-id CHOSEN_MODEL_ID`
>
> 7. Pass the URL provided when prompted to start the download.

After installing the model, one might want to transform your parameters into the format that is suitable for hf (huggingface).

🤗Transformers actually provide a file called [`convert_llama_weights_to_hf.py`](https://github.com/huggingface/transformers/blob/main/src/transformers/models/llama/convert_llama_weights_to_hf.py) that can be used to do so.

For example, say we've install the `Llama3.1-8B-Instruct`, then we can transform it into hf format like this:
```
python {path_to_transformers_package}/models/llama/convert_llama_weights_to_hf.py \
    --input_dir ~/.llama/checkpoints/Meta-Llama3.1-8B-Instruct \
    --model_size 8B \
    --output_dir {output_folder_name} \
    --llama_version 3
```

## Setup environment
Here, I use python built-in virtual environments `venv` to seperate different environments.

### Train (LLaMA-Factory)
```
python -m venv train
. train/bin/activate
cd LLaMA-Factory
pip install -e .
```

### Evaluate (lm-evaluation-harness)
```
python -m venv eval
. eval/bin/activate
cd lm-evaluation-harness
pip install -r requirements.txt
```


## Usage
I use the server [hpcfund powered by AMD](https://www.amd.com/en/corporate/hpc-fund.html) to conduct all the experiments.

This server is maintained under [slurm](https://slurm.schedmd.com/documentation.html), so all the scripts are written to cater their requirement.

> [!WARNING]
> The path to site-packages in the line `export PYTHONPATH="$WORK/eval/env/lib/python3.9/site-packages:$PYTHONPATH"` which is written inside `eval.sh` and `train.sh` might need to be changed.

### Train
```
sbatch run_train.sh
```
### Evaluate
```
sbatch run_eval.sh
```
### Chat

Since the HPC server is suitable for submitting tasks rather then this kind of interactive chatting, 
it is not suggest to chat with model on hpc server.

Instead, you can use your own device to do so. The minimumm requirement of RAM for Llama3.1-8B with 1GPU is 20GBs.

Here, I still provide the script that I used to chat with model in `scripts/chat.sh`.