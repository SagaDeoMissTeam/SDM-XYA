import crafttweaker.api.entity.LivingEntity;
import crafttweaker.api.data.MapData;
import stdlib.List;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.DoubleData;
import crafttweaker.api.item.IItemStack;
import mods.rpgworld.utils.CustomRandom;
import mods.crtultimate.math.Random;

        /*----------------------------------------------------------------
            Класс атрибутов/характеристик существа
        ------------------------------------------------------------------*/
public class EntityStateMachine{

    public var entity as LivingEntity;
    public var propertyList as List<PlayerStatBase> = new List<PlayerStatBase>();

    public this(){
    }

    public this(entity as LivingEntity){
        this.entity = entity;
    }

    public static of(entity as LivingEntity) as EntityStateMachine{
        /*----------------------------------------------------------------
            Позволяет получить характеристики существа если они есть
            Позволяет создать новые характеристики существа если их нет
        ------------------------------------------------------------------*/
        val data as MapData = entity.customData as MapData;
        var state as EntityStateMachine = new EntityStateMachine(entity);
        if("sdmData" in data){
            if("entitySateMachine" in data["sdmData"]){
                state.deserialize(data["sdmData"]["entitySateMachine"]);
                return state;
            }
        }

        state.generateBaseStats();
        state.syncData();
        return state;
    }

    public serialize() as MapData{
        /*----------------------------------------------------------------
            Метод сохраниения характеристик в MapData
        ------------------------------------------------------------------*/
        val data as MapData = new MapData();
        var list as List<IData> = new List<IData>();
        for property in propertyList{
            list.add(property.serialize());
        }
        var dataList as ListData = new ListData(list);
        data.merge({"propertyList": dataList});
        return data;
    }

    public deserialize(data as MapData) as void{
        /*----------------------------------------------------------------
            Метод загрузки характеристик из MapData
        ------------------------------------------------------------------*/
        if(data.isEmpty) return;
        propertyList = new List<PlayerStatBase>();
        var dataList as ListData = data["propertyList"] as ListData;
        for dataFromList in dataList{
            if("value" in dataFromList){
                if(dataFromList["value"] is DoubleData){
                    propertyList.add(new PlayerStatValue(dataFromList["id"].toString(), dataFromList["value"].asDouble()));
                }
            }
        }
    }

    public generateBaseStats() as void{
        /*----------------------------------------------------------------
            Метод генерации базовых характеристик существа
        ------------------------------------------------------------------*/
        propertyList = new List<PlayerStatBase>();

        var statsList as List<string> = ["void_damage", "divine_damage", "chaos_damage", "void_resist", "divine_resist", "chaos_resist", "damage_bonus", "damage_reduce_bonus"] as string[] as List<string>;
        var maxValuesStats as int = Random.nextInt(1, 200);
        var sum as double = 0.0;
        var d1 as List<string> = [] as string[] as List<string>;
        var statsValues as double[string] = {};

        while(sum < maxValuesStats){
            var stat as int = Random.nextInt(statsList.length as int);
            var name as string = statsList[stat];
            var value as double = Random.nextDouble();

            if(name in d1) {
                value = statsValues[name] + value;
                statsValues[name] = value;
            }
            else {
                d1.add(name);
                statsValues[name] = value;
            }
            sum += value;
        }

        if("void_damage" in  statsValues){
            propertyList.add(new PlayerStatValue("void_damage", statsValues["void_damage"]));
        } else propertyList.add(new PlayerStatValue("void_damage", 0.0));
        if("divine_damage" in statsValues){
            propertyList.add(new PlayerStatValue("divine_damage", statsValues["divine_damage"]));
        } else propertyList.add(new PlayerStatValue("divine_damage", 0.0));
        if("chaos_damage" in statsValues){
            propertyList.add(new PlayerStatValue("chaos_damage", statsValues["chaos_damage"]));
        } else propertyList.add(new PlayerStatValue("chaos_damage", 0.0));
        if("void_resist" in statsValues){
            propertyList.add(new PlayerStatValue("void_resist", statsValues["void_resist"]));
        } else propertyList.add(new PlayerStatValue("void_resist", 0.0));
        if("divine_resist" in statsValues){
            propertyList.add(new PlayerStatValue("divine_resist", statsValues["divine_resist"]));
        } else propertyList.add(new PlayerStatValue("divine_resist", 0.0));
        if("chaos_resist" in statsValues){
            propertyList.add(new PlayerStatValue("chaos_resist", statsValues["chaos_resist"]));
        } else propertyList.add(new PlayerStatValue("chaos_resist", 0.0));
        if("damage_bonus" in statsValues){
            propertyList.add(new PlayerStatValue("damage_bonus", statsValues["damage_bonus"]));
        } else propertyList.add(new PlayerStatValue("damage_bonus", 0.0));
        if("damage_reduce_bonus" in statsValues){
            propertyList.add(new PlayerStatValue("damage_reduce_bonus", statsValues["damage_reduce_bonus"]));
        } else propertyList.add(new PlayerStatValue("damage_reduce_bonus", 0.0));
        
        propertyList.add(new PlayerStatValue("redF", 50.0));
        propertyList.add(new PlayerStatValue("greenF", 50.0));
        propertyList.add(new PlayerStatValue("blueF", 50.0));
        propertyList.add(new PlayerStatValue("alpha", 255.0));

        propertyList.add(new PlayerStatValue("protect_class", 0.0));


        getGodSupport();
    }

    public getGodSupport() as void{
        
    }

    public syncData() as void{
        /*----------------------------------------------------------------
            Метод синхронизации новых данных существа
        ------------------------------------------------------------------*/
        if(!("sdmData" in entity.customData)) entity.updateCustomData({"sdmData" : new MapData()});
        val data = entity.customData["sdmData"];
        data["entitySateMachine"] = new MapData();
        data["entitySateMachine"] = serialize();
    }

    public getStatsMap() as PlayerStatBase[string]{
        var map as PlayerStatBase[string] = {};

        for stat in propertyList{
            map[stat.id] = stat;
        }
        return map;
    }

    public getStatsKey() as List<string>{
        var list as List<string> = new List<string>();
        for stat in propertyList{
            list.add(stat.id);
        }

        return list;
    }
}