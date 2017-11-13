package com.calendar.project.controller;

import org.apache.log4j.Logger;
import org.springframework.http.MediaType;
import com.calendar.project.dao.UserDao;
import com.calendar.project.model.EventType;
import com.calendar.project.model.TagType;
import com.calendar.project.service.SecurityService;
import com.calendar.project.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import com.calendar.project.model.Event;
import com.calendar.project.model.User;
import com.calendar.project.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class EventController {

    @Autowired
    private SecurityService securityService;

    @Autowired
    private EventService eventService;

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserService userService;

    private static final Logger LOGGER = Logger.getLogger(EventController.class);

    @RequestMapping(value = "/events", method = RequestMethod.GET)
    public String showAllEvents(Model model) {
        LOGGER.info("Request of \"/events\" page GET");
        model.addAttribute("events", eventService.getAllEvents());
        LOGGER.info("Opening of \"/events\" page");
        return "events";
    }

    @RequestMapping(value = "/events", method = RequestMethod.POST)
    public String showAllEvents(Model model, String filterByKeyword) {
        LOGGER.info("Request of \"/events\" page POST");
        model.addAttribute("filterByKeyword", filterByKeyword);

        model.addAttribute("events", eventService.getEventsByKeyword(filterByKeyword));
        LOGGER.info("Opening of \"/events\" page");
        return "events";
    }

    @RequestMapping(value = "/updateEvent", method = RequestMethod.GET)
    public String updateEvent(int eventId, Model model){
        LOGGER.info("Request of \"/updateEvent\" page GET");
        model.addAttribute("eventForm", eventService.getEvent(eventId));
        LOGGER.info("Opening of \"/updateEvent\" page");
        return "updateEvent";
    }

    @RequestMapping(value = "/updateEvent", method = RequestMethod.POST)
    public String updateEvent(@ModelAttribute("eventForm") Event eventForm, Model model) {
        LOGGER.info("Request of \"/updateEvent\" page POST");
        List<User> participans = new LinkedList<>();
        for (User u : eventForm.getParticipants()) {
            u.setId(Long.parseLong(u.getUsername()));   // TODO investigate why username is set instead of id
            participans.add(userDao.getUser(u.getId()));
        }

        eventForm.setParticipants(participans);
        model.addAttribute("eventForm", eventForm);
        eventService.updateEvent(eventForm);
        LOGGER.info("Redirect to \"/userPage\" page");
        return "redirect:/userPage";
    }

    @RequestMapping(value = "/deleteEvent", method = RequestMethod.GET)
    public String deleteEvent(int eventId, Model model){
        LOGGER.info("Request of \"/deleteEvent\" page GET");
        model.addAttribute("eventForm", eventService.getEvent(eventId));
        LOGGER.info("Opening of \"/deleteEvent\" page");
        return "deleteEvent";
    }

    @RequestMapping(value = "/deleteEvent", method = RequestMethod.POST)
    public String deleteEvent(@ModelAttribute("eventForm") Event event) {
        LOGGER.info("Request of \"/deleteEvent\" page POST");
        eventService.deleteEvent(event);
        LOGGER.info("Redirect to \"/userPage\" page");
        return "redirect:/userPage";

    }

    @RequestMapping(value = "/createEvent", method = RequestMethod.GET)
    public String createEvent(Model model) {
        LOGGER.info("Request of \"/createEvent\" page GET");
        Event event = new Event();
        List<User> participants = userService.getAllUsers().stream().collect(Collectors.toList());
        event.setParticipants(participants);
        model.addAttribute("eventForm", event);
        LOGGER.info("Opening of \"/createEvent\" page");
        return "createEvent";
    }

    @RequestMapping(value = "/createEvent", method = RequestMethod.POST)
    public String createEvent(@ModelAttribute("eventForm") Event eventForm, RedirectAttributes redirectAttributes) {
        LOGGER.info("Request of \"/createEvent\" page POST");
        List<User> participants = new LinkedList<>();
        for (User u : eventForm.getParticipants()) {
            u.setId(Long.parseLong(u.getUsername()));   // TODO investigate why username is set instead of id
            participants.add(userService.getUser(u.getId()));
        }

        eventForm.setParticipants(participants);
        User user = securityService.findLoggedInUsername();
        eventForm.setAuthor(userService.findByUsername(user.getUsername()));  // TODO maybe it is better to move to service
        eventService.saveEvent(eventForm);
        redirectAttributes.addAttribute("eventId", eventForm.getId());
        LOGGER.info("Redirect to \"/showEvent\" page");
        return "redirect:/showEvent";
    }

    @RequestMapping(value = "/showEvent", method = RequestMethod.GET)
    public String showEvent(Model model, int eventId){
        LOGGER.info("Request of \"/showEvent\" page GET");
        Event event = eventService.getEvent(eventId);

        model.addAttribute("eventForm", event);
        LOGGER.info("Opening of \"/showEvent\" page");
        return "showEvent";
    }

    @RequestMapping(value = "/getParticipantsByEvent", method = RequestMethod.GET,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(HttpStatus.OK)
    public @ResponseBody List<User> getEventInJSON(int eventId){
        LOGGER.info("Receives ID of event");
        List<User> participantsByEvent = eventService.getParticipantsByEvent(eventId);
        LOGGER.info("Returns list of participants at event");
        return participantsByEvent;
    }
}
