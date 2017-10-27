package com.calendar.project.dao.impl;

import com.calendar.project.dao.UserDao;
import com.calendar.project.model.User;
import org.hibernate.Hibernate;
import org.springframework.stereotype.Repository;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class UserDaoImpl implements UserDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public User findByUsername(String username) {
        List<User> users = entityManager.createQuery("from User u where u.username=:username", User.class)
                .setParameter("username", username)
                .getResultList();

        return users.stream()
                .findFirst()
                .orElse(null);
    }

    @Override
    public void save(User user) {
        entityManager.persist(user);
    }

    @Override
    public List<User> getAll(){
        List<User> users = entityManager.createQuery("from User", User.class)
                .getResultList();
        return users;
    }

    @Override
    public List<User> getAll(){
        List<User> users = entityManager.createQuery("select u from User u", User.class)
                .getResultList();
        return users;
    }

    @Override
    public void update(User user) {
        entityManager.merge(user);
    }
}
