package se301.monstergame.service;
 
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import com.mongodb.DBAddress;
import com.mongodb.MongoClient;
import com.sun.tools.internal.xjc.reader.xmlschema.bindinfo.BIConversion;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
 
import se301.monstergame.model.Monster;
 
@Service("monsterService")
public class MonsterServiceImpl implements MonsterService{
     
    private static final AtomicLong counter = new AtomicLong();
     
    private static List<Monster> monsters;

    private static MongoOperations mongoOps;

    static {
        try {
            String address = "127.0.0.1:27017";
            String dbname = "monstergame";
            mongoOps = new MongoTemplate(new MongoClient(new DBAddress(address)), dbname);
        } catch (UnknownHostException e){
            e.printStackTrace();
        }
    }
 
    public List<Monster> findAllMonsters() {

        return mongoOps.findAll(Monster.class);
    }
     
    public Monster findById(long id) {
       // for(Monster monster : monsters){
         //   if(monster.getId() == id){
           //     return monster;
            //}
        //}
        BasicQuery query = new BasicQuery("{ id : " + id + " }");
        return mongoOps.findOne(query, Monster.class);
    }
     
    public Monster findByName(String name) {
        //for(Monster monster : monsters){
          //  if(monster.getMonstername().equalsIgnoreCase(name)){
            //    return monster;
            //}
        //}
        BasicQuery query = new BasicQuery("{ username : \"" + name + "\" }");
        return mongoOps.findOne(query, Monster.class);
    }
     
    public void saveMonster(Monster monster) {
        //monster.setId(counter.incrementAndGet());
        //monsters.add(monster);
        monster.setId(getNextId());
        mongoOps.insert(monster);
    }
 
    public void updateMonster(Monster monster) {
        //int index = monsters.indexOf(monster);
        //monsters.set(index, monster);
        mongoOps.save(monster);
    }
 
    public void deleteMonsterById(long id) {
         
        //for (Iterator<Monster> iterator = monsters.iterator(); iterator.hasNext(); ) {
          //  Monster monster = iterator.next();
           // if (monster.getId() == id) {
             //   iterator.remove();
            //}
        //}
        BasicQuery query = new BasicQuery("{ id : " + id + "}");
        mongoOps.remove(query, Monster.class);
    }
 
    public boolean doesMonsterExist(Monster monster) {
        return findByName(monster.getMonstername()) != null;

    }
     
    public void deleteAllMonsters()
    {
        mongoOps.dropCollection(Monster.class);
    }

    public long getNextId() {

            Query query = new Query();
            query.with(new Sort(Sort.Direction.DESC, "_id"));
            query.limit(1);
            Monster maxIdUser = mongoOps.findOne(query, Monster.class);
            if(maxIdUser == null) {
                return 0;
            }
            else {
                long nextId = maxIdUser.getId() + 1;
                return nextId;
            }

    }
 
}