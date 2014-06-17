class Fluentd
  module Setting
    class InTail
      include ActiveModel::Model
      attr_accessor :path, :tag, :format, :time_format, :rotate_wait, :pos_file, :read_from_head, :refresh_interval

      validates :path, presence: true
      validates :tag, presence: true
      #validates :format, presence: true

      def to_conf
        <<-XML.strip_heredoc.gsub(/^[ ]+\n/m, "")
          <source>
            type tail
            path #{path}
            tag #{tag}
            #{read_from_head.to_i.zero? ? "" : "read_from_head true"}
            #{pos_file.present? ? "pos_file #{pos_file}" : ""}
            #{rotate_wait.present? ? "rotate_wait #{rotate_wait}" : ""}
            #{refresh_interval.present? ? "refresh_interval #{refresh_interval}" : ""}
          </source>
        XML
      end
    end
  end
end
