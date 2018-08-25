class DrainMissQueueService
  def initialize
    @drain_service = DrainQueueService.new('misses')
  end

  def run
    @drain_service.call do |row|
      create_miss(*row)
    end
  end

  private

  def create_miss(domain, ident, raddr, ua)
    Miss.create(
      domain: domain, link_ident: ident, remote_address: raddr, user_agent: ua
    )
  end
end
