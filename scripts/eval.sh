module purge
module load hpcfund
module load rocm
module load pytorch
source eval/bin/activate
export PYTHONPATH="$WORK/eval/env/lib/python3.9/site-packages:$PYTHONPATH"

HIP_VISIBLE_DEVICES=0,1,2,3 \
    lm_eval --model hf \
    --model_args pretrained=Llama3.1-8B-Instruct-hf \
    --tasks medmcqa \
    --num_fewshot 0 \
    --batch_size auto \
    --log_samples \
    --output_path result/ \
    --trust_remote_code \