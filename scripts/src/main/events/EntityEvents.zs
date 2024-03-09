import crafttweaker.forge.api.event.entity.player.PlayerLoggedInEvent;
import mods.rpgworld.events.StructureSaveEvent;
import mods.rpgworld.Manager;
import crafttweaker.forge.api.event.entity.living.LivingDamageEvent;
import crafttweaker.api.entity.Entity;
import crafttweaker.api.entity.LivingEntity;
import crafttweaker.api.entity.type.player.Player;
import crafttweaker.forge.api.event.entity.living.LivingAttackEvent;
import mods.crtultimate.events.entity.player.PlayerChangedInventoryEvent;
import crafttweaker.forge.api.event.entity.player.PlayerLoggedOutEvent;
import mods.crtultimate.events.entity.living.curio.CurioChangeEvent;
import crafttweaker.forge.api.event.entity.EntityJoinLevelEvent;
import crafttweaker.forge.api.interact.PlayerInteractEvent;
import crafttweaker.forge.api.event.interact.EntityInteractEvent;
import crafttweaker.api.world.ServerLevel;
import crafttweaker.forge.api.event.item.EntityItemPickupEvent;
import crafttweaker.api.entity.type.player.ServerPlayer;

import mods.rpgworld.utils.CustomRandom;

import stdlib.List;


    /*----------------------------------------------------------------
        Класс событий связанных с существами
    ------------------------------------------------------------------*/
public class EntityEvents{

    //----------------------------------------------------------------
    protected static onPlayerLoggedInEvent() as void{
        events.register<crafttweaker.forge.api.event.entity.player.PlayerLoggedInEvent>(event => {
            val player = event.entity;
            val level = player.level;
            if(level.isClientSide) return;

            Developers.updateData(player);
            PlayerDataBase.of(player).deserialize();
            if(!("havePlaing" in player.customData)){
                Manager.openScreen(player);
            }

            // PlayerStateMachine.of(player).syncData();
        });
    }

    protected static onPlayerLoggedOutEvent() as void{
        events.register<crafttweaker.forge.api.event.entity.player.PlayerLoggedOutEvent>(event => {
            val player = event.entity;
            val level = player.level;
            if(level.isClientSide) return;
            PlayerStateMachine.of(player).syncData();
        });
    }

    //----------------------------------------------------------------
    protected static onStructureSaveEvent() as void{
        events.register<mods.rpgworld.events.StructureSaveEvent>(event => {
            val player as Player? = event.player;
            if(player == null) return;
            val level = player.level;
            if(level.isClientSide) return;

            event.cancel();
        });
    }

    //----------------------------------------------------------------
    protected static onEntityDamageEvent() as void{
        events.register<crafttweaker.forge.api.event.entity.living.LivingDamageEvent>(event => {
            var damageAmount = event.amount;
            var damagedEntity = event.entity;
            var level = damagedEntity.level;
            if(level.isClientSide) return;

            if(event.source.entity != null){
                var playerStats as PlayerStatBase[string] = {};
                var playerDufficulty as PlayerDificult = PlayerDificult.NONE;
                var playerProperty as List<PlayerProperty> = new List<PlayerProperty>();
                var damagerEntity = event.source.entity;

                if(damagerEntity is Player){

                    val damagerPlayer as Player = damagerEntity as Entity as Player;
                    playerDufficulty = PlayerUtils.getPlayerDificult(damagerPlayer);
                    playerProperty = PlayerUtils.getPlayerDificultPrperty(damagerPlayer);
                    playerStats = PlayerUtils.getPlayerStats(damagerPlayer);

                    if(PlayerProperty.MISSKILL in playerProperty) {
                        var amountMissChance = (((playerStats["miss_chance"] as PlayerStatValue).value as double) / 100) - ((playerStats["miss_reduce"] as PlayerStatValue).value as double / 100);
                        var chanceMiss = CustomRandom.getRandom(0.0, 1.0, amountMissChance);
                        if(chanceMiss == 0.0){
                            //TODO: Изменить вид оповещения промохов
                            damagerPlayer.sendMessage("Miss");
                            event.cancel();
                            return;
                        }
                    }
                    PlayerStatsUtils.calculateDamage(event, damagerPlayer);
                }

                if(damagedEntity is Player){

                    var damagedPlayer = damagedEntity as Player;
                    playerStats = PlayerUtils.getPlayerStats(damagedPlayer);
                    playerDufficulty = PlayerUtils.getPlayerDificult(damagedPlayer);
                }
            }

        });
    }

    //----------------------------------------------------------------
    protected static onPlayerInventoryChanceEvent() as void{
        events.register<mods.crtultimate.events.entity.player.PlayerChangedInventoryEvent>(event => {
            var player = event.entity;
            val level = player.level;
            if(level.isClientSide) return;

            PlayerStateMachine.of(player).updateStats();
        });
    }

    //----------------------------------------------------------------
    protected static onCurioChangeEvent() as void{
        events.register<mods.crtultimate.events.entity.living.curio.CurioChangeEvent>(event => {
            var player = event.entity;
            val level = player.level;
            if(level.isClientSide) return;
            if(player is Player) {
                var machine = PlayerStateMachine.of(player as Player);
                machine.updateStatsOnlyCurio(true);
                machine.syncData();
            }
        });
    }

    //----------------------------------------------------------------
    protected static onEntityJoinLevelEvent() as void{
        events.register<crafttweaker.forge.api.event.entity.EntityJoinLevelEvent>(event => {
            var level = event.level;
            if(level.isClientSide) return;
            if(event.entity is LivingEntity){
                var entity as LivingEntity = event.entity as LivingEntity;

                if(entity is Player) return;

                EntityStateMachine.of(entity).syncData();

                var serverLevel as ServerLevel = level as ServerLevel;
                // Manager.syncEntityData(entity, serverLevel.server);
            }
        });
    }

    //----------------------------------------------------------------
    protected static onEntityInteractEvent() as void{
        events.register<crafttweaker.forge.api.event.interact.EntityInteractEvent>(event => {
            var player = event.entity as Player;
            if(player.level.isClientSide || event.hand != <constant:minecraft:interactionhand:main_hand>) return;


            PlayerData.savePlayerInventory(player as ServerPlayer);
            player.sendMessage(EntityStateMachine.of(event.target).serialize() as string);
            player.sendMessage("--------------------------------");
            player.sendMessage(player.customData as string);
        });
    }

    //----------------------------------------------------------------
    protected static onPlayerItemPickUpEvent() as void{
        events.register<crafttweaker.forge.api.event.item.EntityItemPickupEvent>(event => {
            var player = event.entity as Player;
            if(player.level.isClientSide) return;

            if(event.item.getItem() == <item:minecraft:bedrock>){
                for key, curio in player.getCuriosInventory().curios{
                    curio.stacks.setStackInSlot(0, <item:minecraft:air>);
                }
                // for i in 0 .. 10 {
                //     player.addItem(LootUtils.createItem());
                // }
            }
        });
    }

    //----------------------------------------------------------------
    public static init() as void{
        onEntityDamageEvent();
        onStructureSaveEvent();
        onPlayerLoggedInEvent();
        onPlayerLoggedOutEvent();
        onCurioChangeEvent();
        onPlayerInventoryChanceEvent();
        onEntityJoinLevelEvent();
        onEntityInteractEvent();
        onPlayerItemPickUpEvent();
    }
}