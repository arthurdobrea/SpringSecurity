package com.calendar.project.service.impl;

import com.calendar.project.dao.NotificationDao;
import com.calendar.project.model.Event;
import com.calendar.project.model.EventsUsers;
import com.calendar.project.model.MessageBroadcast;
import com.calendar.project.model.User;
import com.calendar.project.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class NotificationServiceImpl implements NotificationService {

    @Autowired
    private SimpMessagingTemplate template;

    @Autowired
    private NotificationDao notificationDao;

    @Override
    public void sendToAll(String destination, Event eventForm) {
        template.convertAndSend(destination,new MessageBroadcast("&lt;b&gt;"
                +eventForm.getTitle() + " " + eventForm.getLocation() + "&lt;/b&gt;"));
    }
    @Override
    public void sendToAllParticipants(List<User> users,Event eventForm) {
        for(User it: users){
        template.convertAndSendToUser(it.getUsername(), "/queue/reply",new MessageBroadcast("&lt;b&gt;"
                +eventForm.getTitle() + " " + eventForm.getLocation() + "&lt;/b&gt;"));
        }
    }
    @Override
    public void sendToSpecificUser(String username,Event eventForm){
            template.convertAndSendToUser(username, "/queue/reply",new MessageBroadcast("&lt;b&gt;"
                    +eventForm.getTitle() + " " + eventForm.getLocation() + "&lt;/b&gt;"));

    }


    @Transactional
    public void save(EventsUsers eventsUsers){
        notificationDao.save(eventsUsers);
    }

    @Override
    public List<EventsUsers> getUnchekedEvents(User user) {
        return notificationDao.getUnchekedEvents(user);
    }
}
