#!/bin/bash
# Install Java 17 and fix Jenkins

echo "=========================================="
echo "Installing Java 17 for Jenkins"
echo "=========================================="
echo ""

# Install Java 17
echo "Installing Amazon Corretto 17 (Java 17)..."
sudo amazon-linux-extras enable corretto17
sudo yum install -y java-17-amazon-corretto

# Verify Java 17 is installed
echo ""
echo "Verifying Java 17 installation..."
java -version

# Set Java 17 as default
echo ""
echo "Setting Java 17 as default..."
sudo alternatives --set java /usr/lib/jvm/java-17-amazon-corretto.x86_64/bin/java

# Verify the change
echo ""
echo "Current Java version:"
java -version

# Stop Jenkins
echo ""
echo "Stopping Jenkins..."
sudo systemctl stop jenkins

# Reset failed state
sudo systemctl reset-failed jenkins

# Reload systemd
sudo systemctl daemon-reload

# Wait a moment
sleep 3

# Start Jenkins with Java 17
echo ""
echo "Starting Jenkins with Java 17..."
sudo systemctl start jenkins

# Wait for Jenkins to start
echo ""
echo "Waiting 60 seconds for Jenkins to initialize..."
sleep 60

# Check status
echo ""
echo "Jenkins status:"
sudo systemctl status jenkins --no-pager

# Check if Jenkins is accessible
echo ""
echo "Checking Jenkins web interface..."
if curl -s http://localhost:8080 | grep -q Jenkins; then
    echo "✓ SUCCESS! Jenkins is running!"
    echo ""
    echo "=========================================="
    echo "Jenkins Initial Admin Password:"
    echo "=========================================="
    if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
        sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    else
        echo "Password file not ready yet. Wait 1-2 minutes and run:"
        echo "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    fi
    echo ""
    echo "=========================================="
    echo "Jenkins URL: http://13.61.193.111:8080"
    echo "=========================================="
else
    echo "Jenkins is still starting up. Wait 2-3 minutes and check:"
    echo "curl http://localhost:8080"
    echo ""
    echo "Or check logs:"
    echo "sudo journalctl -u jenkins -f"
fi
