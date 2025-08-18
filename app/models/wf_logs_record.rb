# frozen_string_literal: true

class WfLogsRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: {writing: :wf_logs}
end
