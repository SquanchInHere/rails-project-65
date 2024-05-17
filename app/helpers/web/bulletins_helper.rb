# frozen_string_literal: true

module Web
  module BulletinsHelper
    def bulletin_states
      db_states = Bulletin.aasm.states.map(&:name)
      db_states.map { |state| [t("web.bulletins.state.#{state}"), state] }
    end
  end
end
