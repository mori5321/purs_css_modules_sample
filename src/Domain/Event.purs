module Domain.Event (
  class Eventable,
  toEvent,
  Event
) where


class Eventable a where
  toEvent :: a -> Event 
  
data Event = MkEvent { description :: String
                     }
