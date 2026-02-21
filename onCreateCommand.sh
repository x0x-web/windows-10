export REPOSITORY=windows-10

rm --recursive --force /tmp/$REPOSITORY
mkdir --parents /tmp/$REPOSITORY/windows
mv --force /workspaces/$REPOSITORY/.devcontainer /tmp/$REPOSITORY/.devcontainer

rm --recursive --force /workspaces/$REPOSITORY
mkdir --parents /workspaces/$REPOSITORY/windows
mv --force /tmp/$REPOSITORY/.devcontainer /workspaces/$REPOSITORY/.devcontainer

cp /workspaces/$REPOSITORY/.devcontainer/helpers/start /usr/local/bin/start
cp /workspaces/$REPOSITORY/.devcontainer/helpers/stop /usr/local/bin/stop
cp /workspaces/$REPOSITORY/.devcontainer/helpers/restart /usr/local/bin/restart
cp /workspaces/$REPOSITORY/.devcontainer/helpers/reset /usr/local/bin/reset
cp /workspaces/$REPOSITORY/.devcontainer/helpers/rebuild /usr/local/bin/rebuild
cp /workspaces/$REPOSITORY/.devcontainer/helpers/remove /usr/local/bin/remove
cp /workspaces/$REPOSITORY/.devcontainer/helpers/kill /usr/local/bin/kill
chmod +x /usr/local/bin/start
chmod +x /usr/local/bin/stop
chmod +x /usr/local/bin/restart
chmod +x /usr/local/bin/reset
chmod +x /usr/local/bin/rebuild
chmod +x /usr/local/bin/remove
chmod +x /usr/local/bin/kill



{
    echo "services:"
    echo "  windows:"
    echo "    container_name: windows"
    echo "    image: dockurr/windows:latest"
    echo "    environment:"
    echo "      VERSION: \"tiny10\""
    echo "      CPU_CORES: $(nproc --all)"
    echo "      RAM_SIZE: $(free --gibi | grep 'Mem:' | awk '{print $7}')G"
    echo "      DISK_SIZE: $(df --human-readable --block-size G /workspaces | grep '/workspaces' | awk '{print $4}')"
    echo "      DISK2_SIZE: $(df --human-readable --block-size G /tmp | grep '/tmp' | awk '{print $4}')"
    echo "      BOOT_MODE: windows"
    echo "      TPM: Y"
    echo "      KVM: Y"
    echo "      RAM_CHECK: N"
    echo "      MTU: 1486"
    echo "      DISPLAY: web"
    echo "      DEBUG: Y"
    echo "    ports:"
    echo "      - 3389:3389/tcp"
    echo "      - 3389:3389/udp"
    echo "      - 5900:5900/tcp"
    echo "      - 5900:5900/udp"
    echo "      - 8006:8006/tcp"
    echo "      - 8006:8006/udp"
    echo "    devices:"
    echo "      - /dev/kvm"
    echo "      - /dev/net/tun"
    echo "      - /dev/vhost-net"
    echo "    cap_add:"
    echo "      - ALL"
    echo "    security_opt:"
    echo "      - seccomp=unconfined"
    echo "    volumes:"
    echo "      - /workspaces/$REPOSITORY/windows:/storage"
    echo "      - /tmp/$REPOSITORY/windows:/storage2"
    echo "      - /workspaces/$REPOSITORY:/data"
    echo "    privileged: true"
    echo "    restart: on-failure"
} > /workspaces/$REPOSITORY/windows/windows.yaml

echo ""

for ((i = 130; i >= 0; i--)); do
    echo "Your GitHub Codespaces will start in $i seconds."
    sleep 1
done

echo ""
