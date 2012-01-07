class ClassRecord < ActiveRecord::Base
  belongs_to :grade

  validates_presence_of :grade


  def date
    (arrival || Time.now.utc).strftime("%d/%m/%Y")
  end

  def time_in
    arrival || Time.now.utc - (Time.now.utc.min).minutes
  end


  def time_out
    departure || time_in + 1.hour
  end

  def delta
    ((departure - arrival)/3600).round(1)
  end

  def teacher_attendance
    teacher ? 1 : 0
  end

  def teacher_attendance=(value)
    if value.to_i == 1
      self.teacher = true
    else
      self.teacher = false
    end
  end

  def date_son
    if arrival.nil?
      {:year => Time.now.utc.year, :month => Time.now.utc.month, :day => Time.now.utc.day }.to_json
    else
      {:year => arrival.year, :month => arrival.month, :day => arrival.day }.to_json
    end
  end

  # fixes parameters hash from form, to use arrival and departure with full datetime
  def self.fix_params(params)

    date = JSON.parse(params[:class_record][:date_son])
    
    hour_in = params[:class_record]["time_in(4i)"].to_i
    minute_in = params[:class_record]["time_in(5i)"].to_i
    
    hour_out = params[:class_record]["time_out(4i)"].to_i
    minute_out = params[:class_record]["time_out(5i)"].to_i
    
    params[:class_record].merge!(
      :arrival => Time.utc(date["year"], date["month"], date["day"], hour_in, minute_in),
      :departure => Time.utc(date["year"], date["month"], date["day"], hour_out, minute_out)
    )
    return params
  end

end
