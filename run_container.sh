source matlab_credential
source matlab_name

if [ $# = 0 ]; then
    echo at least 1 arg required
    exit 1
fi

run_matlab_file=$1
mount_volume=${2:-$(pwd)}

command="docker run -v $mount_volume:/workspace -it --rm --name $MATLAB_CONTAINER_NAME $MATLAB_IMAGE_NAME matlab -batch $run_matlab_file"

expect -c "
    spawn ${command}
    expect \"email\"
    send \"${email}\n\"
    expect \"password\"
    send \"${password}\n\"
    expect \"this line never comes\"
"