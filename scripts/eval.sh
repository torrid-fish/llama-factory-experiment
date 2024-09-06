module purge
module load hpcfund
module load rocm
module load pytorch
source eval/bin/activate
export PYTHONPATH="$WORK/eval/env/lib/python3.9/site-packages:$PYTHONPATH"


HIP_VISIBLE_DEVICES=0,1,2,3 \
    lm_eval --model hf \
    --model_args pretrained=Llama3.1-8B-Instruct-hf,peft=saves/LLaMA3.1-8B-Chat/lora/checkpoint-1600 \
    --tasks medmcqa \
    --num_fewshot 0 \
    --log_samples \
    --batch_size auto \
    --output_path result/ \
    --trust_remote_code