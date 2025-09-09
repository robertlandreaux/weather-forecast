class WfLogsRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: {writing: :wf_logs, reading: :wf_logs}
end
