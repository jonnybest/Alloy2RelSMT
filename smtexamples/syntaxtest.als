sig State { 
  holds, waits: Process -> Mutex ,
  valid : holds ++ waits
}

sig Process {}
sig Mutex {}