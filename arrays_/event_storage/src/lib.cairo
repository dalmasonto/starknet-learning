use core::traits::Into;
use core::array::ArrayTrait;
use debug::PrintTrait;

#[derive(Drop, Copy)]
struct Event{
    name: felt252,
    ticket_price: u16
}

#[generate_trait]
impl EventImpl of EventTrait {
    fn display_info(ref self: Event){
        self.name.print();
        self.ticket_price.print();
    }
}


#[derive(Drop)]
struct EventStore{
    events: Array<Event>,
}


#[generate_trait]
impl EventStoreImpl of EventStoreTrait {
    fn add_event(ref self: EventStore, event: Event){
        self.events.append(event);
    }
    fn display_events(self: @EventStore){
        let len = self.events.len();
        let mut i = 0;

        loop {
            if (i >= len) {
                break;
            }
            let mut event: Event = *self.events[i];
            event.display_info(); // event.ticket_price.print();
            i += 1;
        }
    }
}
fn main(){
    let mut eventStore = EventStore {
        events: ArrayTrait::new(),
    };

    eventStore.add_event(Event{name: 'Event 1', ticket_price: 1});
    eventStore.add_event(Event{name: 'Event 2', ticket_price: 2});

    eventStore.display_events();
    eventStore.display_events();
}
