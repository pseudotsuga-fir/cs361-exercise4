# Exercise 5 Part 1 (Exception Handling)

class AuditError < StandardError ; end

class MentalState
  def auditable?
    # true if the external service is online, otherwise false
  end

  def audit!
    begin
      try_to_audit
    rescue AuditError => e
      puts e.message
    end
  end

  def try_to_audit
    # try and audit here...
    raise AuditError.new("Unable to audit")
  end

  def do_work
    # Amazing stuff...
  end
end

def audit_sanity(bedtime_mental_state)
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

new_state = audit_sanity(bedtime_mental_state)




# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

class NullMentalState < MentalState ; end

def audit_sanity(bedtime_mental_state)
  return NullMentalState unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

new_state = audit_sanity(bedtime_mental_state)
new_state.do_work




# Exercise 5 Part 3 (Wrapping APIs)

require 'candy_service'

class CandyService
  @machine = CandyMachine.new
  
  def prepare_candy_machine
    @machine.prepare
  end

  def machine_ready?
    @machine.ready?
  end

  def machine_make!
    @machine.make
  end

candy_machine = CandyService.new
CandyService.prepare_candy_machine

if CandyService.machine_ready?
  CandyService.machine_make!
else
  puts "sadness"
end