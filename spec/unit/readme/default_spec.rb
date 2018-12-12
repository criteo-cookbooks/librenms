# This file is auto-generated by the code_generator
#
# Cookbook Name:: librenms
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'librenms::readme' do
  let(:readme_file) do
    File.join(File.dirname(__FILE__), '../../../README.md')
  end

  it 'exists' do
    expect(File.exist?(readme_file))
  end

  # This is necessary to be published in supermarket
  it 'is non empty' do
    expect(File.read(readme_file)).not_to be_empty
  end
end
