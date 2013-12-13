require 'spec_helper'

describe package('dstat') do
  it { should be_installed }
end

describe command('dstat --version') do
  it { should return_exit_status 0 }
end
