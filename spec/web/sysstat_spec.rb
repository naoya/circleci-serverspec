require 'spec_helper'

describe package('sysstat') do
  it { should be_installed }
end

