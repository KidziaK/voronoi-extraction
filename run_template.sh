docker run -i -v ${INPUT_ROOT}:/shared --shm-size 64g --gpus all --rm --name nvdnet nvd_release:v0 /bin/zsh -c "
    export LD_LIBRARY_PATH=/root/NVDNet/build/bvh-distance-queries/:/opt/conda/lib/:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

    cd /root/NVDNet && /opt/conda/bin/python generate_test_voronoi_data.py /shared 1

    /root/NVDNet/build/src/prepare_evaluate_gt_feature/prepare_evaluate_gt_feature /shared/ndc_mesh /shared/feat/ndc --resolution 256

    cd /root/NVDNet/python && /opt/conda/bin/python test_model.py dataset.root=/shared dataset.output_dir=/shared/voronoi

    cd /shared

    touch test_ids.txt

    echo input >> test_ids.txt

    cd /root/NVDNet && /opt/conda/bin/python scripts/extract_mesh_batched.py /shared/voronoi /shared/mesh /shared/test_ids.txt

    cp /shared/voronoi/input_pred.npy /shared/voronoi_boundaries.npy
    cp /shared/voronoi/input_feat.npy /shared/voronoi_feat.npy

    rm -R /shared/test_ids.txt
    rm -R /shared/voronoi
    rm -R /shared/feat
    rm -R /shared/ndc_mesh

    chown -R $(id -u):$(id -g) /shared/*
"
