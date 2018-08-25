class DrainHitsQueueService
  def initialize
    @drain_service = DrainQueueService.new('hits')
  end

  def run
    @drain_service.call do |(domain, ident, raddr, ua)|
      attrs = { domain: domain, remote_address: raddr, user_agent: ua }

      begin
        link = Link.where(ident: ident).first!

        create_hit link, attrs
      rescue ActiveRecord::RecordNotFound
        create_miss attrs.update(link_ident: ident)
      end
    end
  end

  private

  def create_hit(link, attrs)
    link.hits.create(attrs)
  end

  def create_miss(attrs)
    Miss.create(recorded_as_hit: true, **attrs)
  end
end
