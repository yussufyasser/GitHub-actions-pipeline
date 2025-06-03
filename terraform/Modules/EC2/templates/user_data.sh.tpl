#!/bin/bash


yum update -y
useradd --no-create-home --shell /bin/false prometheus
mkdir /etc/prometheus
mkdir /var/lib/prometheus
chown prometheus:prometheus /etc/prometheus /var/lib/prometheus
cd /tmp
curl -LO https://github.com/prometheus/prometheus/releases/download/v2.51.2/prometheus-2.51.2.linux-amd64.tar.gz
tar xvf prometheus-2.51.2.linux-amd64.tar.gz
cd prometheus-2.51.2.linux-amd64
cp prometheus /usr/local/bin/
cp promtool /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool
cp -r consoles /etc/prometheus
cp -r console_libraries /etc/prometheus
cp prometheus.yml /etc/prometheus/
chown -R prometheus:prometheus /etc/prometheus
cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \\
  --config.file=/etc/prometheus/prometheus.yml \\
  --storage.tsdb.path=/var/lib/prometheus \\
  --web.console.templates=/etc/prometheus/consoles \\
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reexec
systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus

echo "" >> /etc/prometheus/prometheus.yml
echo "  - job_name: 'mongodb_exporter'" >> /etc/prometheus/prometheus.yml
echo "    static_configs:" >> /etc/prometheus/prometheus.yml
echo "      - targets: ['${databaseip}:9216']" >> /etc/prometheus/prometheus.yml
