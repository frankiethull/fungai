
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fungai <img src="man/figures/logo.png" align="right" height="139" alt="" />

<!-- badges: start -->
<!-- badges: end -->

{fungai} has been given additional knowledge of over 200+ mushroom
species, it also happens to be a mushroom. fungai is a friendly ai that
helps identify mushrooms and describe them (but never eat them).

## Installation

You can install the development version of fungai like so:

``` r
pak::pak("frankiethull/fungai")
```

### Examples

These are basic examples which show you how to use fungai:

using a prompt with information you have about the mushroom:

``` r
library(fungai)

fungai::fungai(llm_model = "llama3.2-vision",
               prompt    = "hello fungai,
                         I'm trying to identify an orange mushroom that has no gills.
                         it has gill-like ridges, but i think it's a polypore.
                         i found it growing out of the ground in the woods.
                         Cap 5 cm across, stem 7 cm tall * 1 cm thick, 
                         can you reference your dictionary and help me identify it?"
               ) |> cat()
#> Welcome to mycology!
#> 
#> I'm happy to help you with your orange mushroom identification. As you suspected, gill-like ridges are characteristic of some polypores, which belong to the Phylum Basidiomycota.
#> 
#> To provide a more accurate identification, I'll need to rely on general descriptive features rather than direct species reference since we can't match exact descriptions in my training data. That being said, based on your description:
#> 
#> 1.  The orange color and presence of gill-like ridges are key characteristics to consider. Some polypores with such features could be members of the genus Pycnoporellus or Fomitopsis (although these tend to be brownish in color). Another group is the genus Datronia, which includes some species that have a orange-brown cap and gill-like ridges.
#> 2.  The size of the mushroom doesn't necessarily narrow down the identification, as various polypore species can range from small to quite large.
#> 
#> To further refine your search:
#> 
#> *   Consider observing more detailed features of your specimen:
#>     *   Are the gill-like ridges very prominent or more subtle?
#>     *   Does the cap have any notable texture, pores, or other patterns?
#>     *   Is the stem fragile and snaps easily (indicative of soft wood tissue beneath) or sturdy (suggesting growth on a less decayed substrate)?
#>     *   Check for any mycelium or fungal material around the base of the stem
#> 3.  Can you provide more information about the habitat where you found it? This can be crucial in narrowing down possible species, such as:
#>     *   Was it growing near trees, logs, or on soil?
#>     *   What types of vegetation are in the area?
#> 
#> The MyCoBank database and other online resources, include detailed descriptions and images of various mushroom species.
```

using an image of the mushroom:

``` r

image <- ellmer::content_image_file(
                             path   = system.file("images", "6.png", package = "fungai"), 
                             resize = "low"
                             )

fungai::fungai(llm_model = "llava",
               prompt    = image
               ) |> cat()
#>  The image shows two large yellow or orange mushrooms with brown stems sitting on the ground in a grassy area. This type of mushroom is commonly known as porcini and is a wild edible. It can be found in temperate forests throughout Europe, Asia, North Africa, and parts of North America. These mushrooms are typically gathered in late summer or fall when they're fully grown. They're highly sought after for their culinary value, but it's crucial to only consume mushrooms you have personally foraged or identified with certainty since many wild mushrooms can be toxic if ingested without proper knowledge.
```

more generic mushroom questions:

``` r
fungai::fungai(llm_model = "phi4", 
               prompt    = "hello fungai! what mushrooms are found in the US Rocky Mountains?"
               ) |> cat()
#> Hello! The U.S. Rocky Mountains are home to a diverse array of fungi, including many species of mushrooms. Here's an overview of some common types you might find:
#> 
#> 1. **Agaricus bisporus** - Also known as the white button mushroom or portobello when mature, this is commonly cultivated and also found in natural environments.
#> 
#> 2. **Clitocybe nuda** - Known for its delicate, funnel-shaped caps and mild flavor, often collected on account of its edibility.
#> 
#> 3. **Suillus luteus (also known as Slippery Jack)** - Recognizable by its slippery cap surface that’s covered with yellow granules, this mushroom forms symbiotic relationships with coniferous trees.
#> 
#> 4. **Amanita muscaria** and **Amanita phalloides**: While these are found throughout temperate regions including the Rockies, they're particularly noteworthy due to their toxicity. Amanita muscaria is famous for its red cap and white spots, whereas amanita phalloides (the death cap) is highly poisonous.
#> 
#> 5. **Russula species** - Known as brittlegills, these mushrooms are typically bright-colored with brittle caps and are widespread throughout the mountainous regions.
#> 
#> 6. **Boletus edulis** and related species - Such as the coveted porcini or King Bolete, they form symbiotic relationships with conifers and have a distinctive sponge-like surface under their caps instead of gills.
#> 
#> 7. **Cortinarius species** - These mushrooms are diverse in color and often have fibrous threads called cortina hanging from the cap margin, and many can be quite toxic or psychoactive.
#> 
#> 8. **Lyophyllum decastes** (commonly known as woody blewit) - Known for its brown caps with purple edges and edibility when cooked well.
#> 
#> 9. **Tricholoma magnivelare** - Sometimes referred to as “the large cap tricholoma,” it forms mycorrhizal associations with trees, particularly conifers.
#> 
#> 10. **Galerina marginata (Deadly Galerina)** - A highly poisonous species that resembles chanterelles and should be strictly avoided due to its toxicity.
#> 
#> When exploring mushrooms in the Rocky Mountains or anywhere else, always ensure proper identification before consuming them. Some edible varieties can look very similar to toxic ones, and professional expertise is crucial for safe mushroom foraging.
```

``` r
fungai::fungai(llm_model = "llama3.3", 
               prompt    = "hello fungai! can you give me a cool new mycelium catch phrase?"
               ) |> cat()
#> My friend, I'd be delighted to help you with that!
#> 
#> Here are some cool new mycelium catchphrases for you:
#> 
#> 1. **"Spawn the Revolution!"** - Perfect for inspiring change and growth.
#> 2. **"Fungi Forward, Always!"** - A motivational phrase to keep you moving forward.
#> 3. **"Mycelium Mindset: Connect, Adapt, Thrive!"** - Embracing the networked, resilient nature of mycelium.
#> 4. **"Weave Your Web of Wonder!"** - Celebrating the intricate, awe-inspiring connections in the mycelium kingdom.
#> 5. **"Spore-adic Excellence, Every Time!"** - Striving for greatness, one spore at a time.
#> 
#> Which one resonates with you, or would you like me to come up with more options?
```

sharing fungai thoughts between different models:

``` r

fungai::fungai(llm_model = "phi4",
               prompt    = "write a few mushroom puns, 
                            ask yourself which is the best") |>
  fungai::fungai(llm_model = "llama3.3",
                 prompt = _)
#> [1] "What a delightful collection of mushroom puns! 😄 I'll have to review them carefully to decide which one rises to the top (or should I say, \"sprouts\" to the top?).\n\nAfter careful consideration, I think my favorite is... **Spore-ing Success**: When life gives you spores, make... a morel-ish stew! 🍄👏 There's something about the play on words between \"spore-ing\" and \"score-ing\" that really grows on me (I couldn't resist another fungi pun 😊). Plus, the idea of making a morel-ish stew is just so clever and tasty-sounding!\n\nOf course, all the other puns are fun-gi too (sorry, had to!), but **Spore-ing Success** stands out for its creativity and wordplay. Well done! 👏 Do you have a favorite among these, or would you like me to come up with some more mushroom puns? 🤔🍄"
```
