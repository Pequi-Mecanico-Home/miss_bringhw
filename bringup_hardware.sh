REPO_PATH="$(dirname "$(pwd)")"

docker run \
        -it \
        --rm \
        --privileged \
        --net=host \
        --volume /dev:/dev \
        --env DISPLAY="$DISPLAY" \
        --env QT_X11_NO_MITSHM=1 \
        --env LIBGL_ALWAYS_SOFTWARE=0 \
        --volume "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        --cpu-shares 1024  \
        --memory 2g \
        bringhw:came
        