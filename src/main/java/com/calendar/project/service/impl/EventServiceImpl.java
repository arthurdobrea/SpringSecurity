package com.calendar.project.service.impl;

import com.calendar.project.model.enums.EventType;
import com.calendar.project.model.User;
import com.calendar.project.model.enums.TagType;
import com.calendar.project.service.EventService;
import com.calendar.project.dao.EventDao;
import com.calendar.project.model.Event;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class EventServiceImpl implements EventService {

    @Autowired
    private EventDao eventDao;

    private static final Logger LOGGER = Logger.getLogger(EventServiceImpl.class);

    @Override
    public List<Event> getEventsByUser(long userId) {
        return eventDao.getEventsByUser(userId);
    }

    @Override
    public List<Event> getEventsByAuthor(long authorId){
        return eventDao.getEventsByAuthor(authorId);
    }

    @Override
    public Event getEvent (int id){
            return eventDao.getEvent(id);
        }

    @Override
    public List<EventType> getEventTypeList(){
        List<EventType> EventTypeList = new ArrayList<>();

        for(EventType eventType : EventType.values()) {
            EventTypeList.add(eventType);
        }

        return EventTypeList;
    }

    @Override
    public List<Event> getFutureEventsByType(EventType eventType) {
        List<Event> eventList = new ArrayList<>();

        for (Event event : getAllEvents()) {
            String startDate = event.getStart().toString(); // convert to ISO DateTime
            LocalDateTime ldt = LocalDateTime.parse(startDate);

            if (event.getEventType().equals(eventType)&& ldt.isAfter( LocalDateTime.now())) {
                eventList.add(event);
            }
        }

        return eventList;
    }

    @Override
    public List<Event> getEventsByTag(TagType tag){
        return eventDao.getEventsByTag(tag);
    }

    @Override
    public List<Event> getEventsByLocation(String location) {
        return eventDao.getEventsByLocation(location);
    }

    @Override
    public List<Event> getEventsByType(EventType type) {
        return eventDao.getEventsByType(type);
    }

    @Override
    public List<Event> getEventsByKeyword(String keyword) {
        return eventDao.getEventsByKeyword(keyword);
    }

    @Override
    public List<Event> getAllEvents() {
        return eventDao.getAllEvents();
    }

    @Override
    @Transactional(readOnly = false)
    public void saveEvent(Event event){
        eventDao.saveEvent(event);
    }

    @Override
    @Transactional
    public void updateEvent(Event editedEvent){
        Event event = eventDao.getEvent(editedEvent.getId());
        event.setTitle(editedEvent.getTitle());
        event.setEventType(editedEvent.getEventType());
        event.setParticipants(editedEvent.getParticipants());
        event.setDescription(editedEvent.getDescription());
        event.setLocation(editedEvent.getLocation());
        event.setStart(editedEvent.getStart());
        event.setEnd(editedEvent.getEnd());
        eventDao.updateEvent(event);
    }

    @Override
    public List<User> getParticipantsByEvent(int eventId){
        return eventDao.getParticipantsByEvent(eventId);
    }
    @Override
    @Transactional(readOnly = false)
    public void deleteEvent(Event eventToDelete) {
        Event event = eventDao.getEvent(eventToDelete.getId());
        eventDao.deleteEvent(event);}

    @Override
    public List<Event> getEventsByDate(String date) {
        return eventDao.getEventsByDate(date);}

    @Override
    public List<Event> getEventsByPeriod(String firstDate, String secondDate){
            return eventDao.getEventsByPeriod(firstDate, secondDate);
    }

    @Override
    public List<Event> getEventCountByPeriod(String date1, String date2){
        return eventDao.getEventCountByPeriod(date1, date2);
    }

    }
