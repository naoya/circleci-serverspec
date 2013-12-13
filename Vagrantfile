# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "planbcd-centos6.3"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v0.1.0/centos64-x86_64-20131030.box"

  config.vm.define :local do |local|
    local.vm.box = "planbcd-centos6.3"
    local.vm.hostname = "test-circleci"
  end

  config.vm.define :remote do |remote|
    remote.vm.box = "dummy"
    remote.vm.synced_folder "", "", disabled: true
    remote.vm.provider :aws do |aws, override|
      aws.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
      aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
      aws.keypair_name = "circleci keys"

      aws.instance_type = "t1.micro"
      aws.region = "ap-northeast-1"

      ## Private AMI: Amazon Linux + enable tty-less sudo
      aws.ami = "ami-df4320de"

      aws.security_groups = [ 'vagrant' ]
      aws.tags = { 'Name' => 'CircleCI' }

      override.ssh.username = "ec2-user"

      ## This private key is configured on CircleCI
      override.ssh.private_key_path = ENV['AWS_SSH_KEY_PATH']
    end
  end
end
