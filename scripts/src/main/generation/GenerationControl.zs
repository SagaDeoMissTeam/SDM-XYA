import crafttweaker.api.resource.ResourceLocation;

public class GenerationControl{


    public this(){

    }

    public static isVanilla(id as string) as bool{
        return <resource:${id}>.getNamespace() == ("minecraft");
    }
}