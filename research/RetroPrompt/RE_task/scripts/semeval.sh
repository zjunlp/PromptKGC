shot=4

for seed in 1
do
for temp in 0.05
do
for alpha in 0.0001 0.1 5.0 0.05
do
for knn_lambda in 0.1 0.2 0.5
do
echo $seed
echo $temp
echo $alpha
echo $knn_lambda
CUDA_VISIBLE_DEVICES=0 python main.py --max_epochs=40  --num_workers=8 \
    --model_name_or_path roberta-large \
    --accumulate_grad_batches 1 \
    --batch_size 8 \
    --data_dir dataset/semeval/k-shot/$shot-$seed \
    --check_val_every_n_epoch 1 \
    --data_class WIKI80 \
    --max_seq_length 256 \
    --model_class RobertaForPrompt \
    --t_lambda 0.001 \
    --litmodel_class BertLitModel \
    --task_name wiki80 \
    --lr 5e-5 \
    --use_template_words 0 \
    --init_type_words 0 \
    --output_dir ckpt/semeval/kshot/$shot-$seed-knn/ \
    --train_with_knn \
    --knn_mode \
    --temp $temp \
    --alpha $alpha \
    --knn_topk 64 \
    --knn_lambda $knn_lambda
done
done
done
done
