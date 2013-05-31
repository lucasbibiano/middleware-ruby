module Leaseable
  def start_lease(time)
    @startTime = Time.now
    @time = time
  end

  def expired_lease?
    return Time.now - @startTime >= @time
  end

  def renewLease
    @startTime = Time.now
  end
end

class Monitor
  def initialize
    @monitored_objects = []
  end

  def start_verify_leases
    Thread.new do
      loop {
        
        @monitored_objects.each do |obj|
          if obj.expired_lease?
            lease_expired(obj)
          end
        end

        sleep 0.3
      }
    end
  end

  def grant_lease(obj, lease_time)
    obj.start_lease(lease_time)
    @monitored_objects << obj
  end

  def lease_expired(obj)
    puts "Lease ended: " + obj.inspect
    @monitored_objects.delete obj
  end
end

class Foo
  include Leaseable
end

monitor = Monitor.new

foo = Foo.new
foo2 = Foo.new
foo3 = Foo.new

monitor.grant_lease foo, 1
monitor.grant_lease foo2, 2
monitor.grant_lease foo3, 3

monitor.start_verify_leases

loop {
}
