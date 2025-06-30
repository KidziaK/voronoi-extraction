docker run -i -v ${INPUT_ROOT}:/shared --shm-size 64g --gpus all --rm --name nvdnet nvd_release:v0 /bin/zsh -c "
    export DATA_ROOT=/shared
    export ROOT_PATH=/root/NVDNet
    
    cd \"\${ROOT_PATH}\" && /opt/conda/bin/python generate_test_voronoi_data.py \"\${DATA_ROOT}\" 1

    \"\${ROOT_PATH}/build/src/prepare_evaluate_gt_feature/prepare_evaluate_gt_feature\" \"\${DATA_ROOT}/ndc_mesh\" \"\${DATA_ROOT}/feat/ndc\" --resolution 256

    cd \"\${ROOT_PATH}/python\" && /opt/conda/bin/python test_model.py dataset.root=\"\${DATA_ROOT}\" dataset.output_dir=\"\${DATA_ROOT}/voronoi\"
    
    rm -R /shared/feat
    rm -R /shared/ndc_mesh
    cp /shared/voronoi/input_pred.npy /shared/voronoi_boundaries.npy
    chown $(id -u):$(id -g) /shared/voronoi_boundaries.npy
    rm -R /shared/voronoi
"

