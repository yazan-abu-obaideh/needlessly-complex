class EventController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    puts "Create event method called!"
    current = get_current()
    res = JSON.parse(request.raw_post())
    res["received_time"] = Time.now()
    REDIS.set(current, JSON.generate(res))
    render json: res
    update_current(current)
  end

  private
    def get_current()
      current = REDIS.get("current").to_i()
      if current == nil
        puts "current count was nil!"
        current = 0
      else
        puts "current count is " + current.to_s()
      end
      return current
    end
    def update_current(curr)
      new_count = curr + 1
      REDIS.set("current", curr + 1)
      puts "Processed successfully. Updating count to " + new_count.to_s()
    end
end
