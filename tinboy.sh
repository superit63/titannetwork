#!/bin/bash
# Kiểm tra xem Docker đã được cài đặt hay chưa
if ! command -v docker &> /dev/null; then
    # Nếu không, cài đặt Docker
    echo "Docker is not installed. Installing Docker..."

    # Sử dụng lệnh cài đặt Docker cho hệ điều hành cụ thể, ví dụ:
    # Ubuntu/Debian
    # sudo apt-get update
    # sudo apt-get install -y docker.io

    # CentOS/RHEL
    sudo yum install -y docker

    # Fedora
    # sudo dnf install -y docker

    # Khởi động dịch vụ Docker
    sudo systemctl start docker

    # Tự động khởi động Docker khi khởi động hệ thống
    sudo systemctl enable docker

    echo "Docker installed successfully."
fi

# Hỏi người dùng nhập hash
echo "Enter the hash:"
read hash


# Bước 9: Tạo thư mục ~/.titanedge0 nếu chưa tồn tại
mkdir -p ~/.titanedge0

# Bước 10: Chạy container 0 và cấu hình tự động khởi động lại
docker run -dit --name titan0 --restart always -v ~/.titanedge0:/root/.titanedge nezha123/titan-edge

# Chờ một khoảng thời gian cho container khởi động
sleep 10

# Thực hiện hành động cho từng container
docker exec -it titan0 /bin/bash -c "titan-edge bind --hash=$hash https://api-test1.container1.titannet.io/api/v2/device/binding"

