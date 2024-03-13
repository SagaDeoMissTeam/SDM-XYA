/*
    Create By Sixik
*/
import crafttweaker.forge.api.event.entity.living.LivingDamageEvent;
import crafttweaker.api.entity.type.player.Player;
import stdlib.List;
import crafttweaker.api.entity.Entity;
import crafttweaker.api.entity.LivingEntity;
import crafttweaker.api.item.ItemStack;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.data.MapData;
import mods.rpgworld.utils.CustomRandom;


        /*----------------------------------------------------------------
            Класс с методами для взаимодействия с характеристиками
        ------------------------------------------------------------------*/
public class PlayerStatsUtils{

    public static calculateDamage(event as LivingDamageEvent, player as Player) as void{
        var playerProperty as List<PlayerProperty> = PlayerUtils.getPlayerDificultPrperty(player);
        var playerStats as PlayerStatBase[string] = PlayerUtils.getPlayerStats(player);
        var damageAmount = event.amount;
        var weaponStats as float[string] = getItemStats(player.inventory.getSelected().asIItemStack());

        /*----------------------------------------------------------------
                            Переменные с показателями игрока
        ------------------------------------------------------------------*/
        var damage_bonus as float = ((playerStats["damage_bonus"] as PlayerStatValue).value as float) / 100;
        var void_damage as double = (playerStats["void_damage"] as PlayerStatValue).value as double;
        var divine_damage as double = (playerStats["divine_damage"] as PlayerStatValue).value as double;
        var chaos_damage as double = (playerStats["chaos_damage"] as PlayerStatValue).value as double;

        var critical_hit_chance = (playerStats["critical_hit_chance"] as PlayerStatValue).value as double;
        var critical_hit_multiply = (playerStats["critical_hit_multiply"] as PlayerStatValue).value as double;

        var damage_bonus_buff as float = ((playerStats["damage_bonus_buff"] as PlayerStatValue ).value as float) / 100;
        var void_damage_buff as double = (playerStats["void_damage_buff"] as PlayerStatValue ).value as double / 100;
        var divine_damage_buff as double = (playerStats["divine_damage_buff"] as PlayerStatValue ).value as double / 100;
        var chaos_damage_buff as double = (playerStats["chaos_damage_buff"] as PlayerStatValue ).value as double / 100;

        /*----------------------------------------------------------------
                            Калькулятор урона
        ------------------------------------------------------------------*/
        if("damage_bonus" in weaponStats){
            damage_bonus += weaponStats["damage_bonus"];
        }
        if("void_damage" in weaponStats){
            void_damage += weaponStats["void_damage"];
        }
        if("divine_damage" in weaponStats){
            divine_damage += weaponStats["divine_damage"];
        }
        if("chaos_damage" in weaponStats){
            chaos_damage += weaponStats["chaos_damage"];
        }
        if("void_damage_buff" in weaponStats){
            void_damage_buff += (weaponStats["void_damage_buff"] / 100);
        }
        if("divine_damage_buff" in weaponStats){
            divine_damage_buff += (weaponStats["divine_damage_buff"] / 100);
        }
        if("chaos_damage_buff" in weaponStats){
            chaos_damage_buff += (weaponStats["chaos_damage_buff"] / 100);
        }
        if("damage_bonus_buff" in weaponStats){
            damage_bonus_buff += (weaponStats["damage_bonus_buff"] / 100);
        }
        if("critical_hit_chance" in weaponStats){
            critical_hit_chance += (weaponStats["critical_hit_chance"] / 100);
        }
        if("critical_hit_multiply" in weaponStats){
            critical_hit_multiply += (weaponStats["critical_hit_multiply"] / 100);
        }

        var isCrit as bool = false;
        var d1 as double = CustomRandom.getRandom(0.0, 100.0, 0.0);
        if(d1 <= critical_hit_chance && !(critical_hit_chance <= 0.0)){
            isCrit = true;
        }


        var targetResist as float[string] = calculateResist(event.entity);

        damage_bonus += damage_bonus * damage_bonus_buff;
        void_damage += void_damage * void_damage_buff;
        divine_damage += divine_damage * divine_damage_buff;
        chaos_damage += chaos_damage * chaos_damage_buff;

        damage_bonus = damage_bonus - targetResist["damage_reduce_bonus"];
        void_damage = void_damage - targetResist["void_resist"];
        divine_damage = divine_damage - targetResist["divine_resist"];
        chaos_damage = chaos_damage - targetResist["chaos_resist"];

        void_damage = void_damage < 0.0 ? 0.08 : void_damage;
        damage_bonus = damage_bonus < 0.0 ? 0.08 : damage_bonus;
        divine_damage = divine_damage < 0.0 ? 0.08 : divine_damage;
        chaos_damage = chaos_damage < 0.0 ? 0.08 : chaos_damage;

        val totalDamage as float = damageAmount as float + (damageAmount as float * damage_bonus as float) + void_damage as float + divine_damage as float + chaos_damage as float;

        /*----------------------------------------------------------------
                            Конечный результат с критом
        ------------------------------------------------------------------*/
        if(isCrit && !(critical_hit_multiply <= 0.0)){
            event.amount = totalDamage + (totalDamage * critical_hit_multiply as float);
        } else event.amount = totalDamage;
    }

    public static calculateResist(target as LivingEntity) as float[string] {
        /*----------------------------------------------------------------
            Функция с переменными сопративления у атакуемого существа
        ------------------------------------------------------------------*/
        var resistMap as float[string] = {};
        var entityData as EntityStateMachine = EntityStateMachine.of(target);
        var entityStats as PlayerStatBase[string] = entityData.getStatsMap();
        resistMap["chaos_resist"] = (entityStats["chaos_resist"] as PlayerStatValue).value as float;
        resistMap["divine_resist"] = (entityStats["divine_resist"] as PlayerStatValue).value as float;
        resistMap["void_resist"] = (entityStats["void_resist"] as PlayerStatValue).value as float;
        resistMap["damage_reduce_bonus"] = (entityStats["damage_reduce_bonus"] as PlayerStatValue).value as float;

        return resistMap;
    }

    protected static getItemStats(item as IItemStack) as float[string]{
        /*----------------------------------------------------------------
            Функция с в которой мы получаем характеристики оружия
                после передоётся в основной калькулятор
        ------------------------------------------------------------------*/
        var map as float[string] = {};

        if(!item.hasTag) return map;
        var itemData as MapData = new MapData(item.tag.asMap());
        if(itemData.isEmpty() || !("sdm_data" in itemData))  return map;
        itemData = itemData["sdm_data"];

        for key in ItemStats.getKeys(){
            if(key in itemData){
                map[key] = itemData[key] as float;
            }
        }

        return map;
    }
}