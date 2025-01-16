# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include AuthManager
  allow_browser versions: :modern
end
