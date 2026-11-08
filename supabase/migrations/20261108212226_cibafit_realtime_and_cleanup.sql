-- Messaggi in tempo reale anche per lo schema cibafit; rimuove il tracciamento anti-spreco.
set local role postgres;
set local lock_timeout = '5s';
alter publication supabase_realtime add table cibafit.messages;
drop table cibafit.waste_savings;
