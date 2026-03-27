var plantData = [
  {
    "plant_id": "p001",
    "name": "Aloe Vera",
    "description":
        "Aloe Vera is a hardy and low-maintenance medicinal plant known for its healing properties and air-purifying qualities. Thrives in bright, indirect sunlight with minimal watering.",
    "price": 8.50,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/aloe_vera.jpg",
    "category": "Indoor",
    "discount": 10,
    "recommend_for_you": true
  },
  {
    "plant_id": "p002",
    "name": "Monstera Deliciosa",
    "description":
        "Monstera Deliciosa features large, split green leaves that bring a tropical feel to any room. Grows well in indirect light and improves indoor air quality.",
    "price": 18.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Monstera%20Deliciosa.jpg",
    "category": "Indoor",
    "discount": 15,
    "recommend_for_you": true
  },
  {
    "plant_id": "p003",
    "name": "Snake Plant",
    "description":
        "Snake Plant is resilient, survives low light and irregular watering, and helps remove toxins from indoor air. Perfect for offices and bedrooms.",
    "price": 12.00,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Snake%20Plant.jpg",
    "category": "Office",
    "discount": 5,
    "recommend_for_you": false
  },
  {
    "plant_id": "p004",
    "name": "Peace Lily",
    "description":
        "Peace Lily is a beautiful flowering plant with dark green leaves and white blooms. Thrives in low to medium light, improves air quality, and adds elegance indoors.",
    "price": 14.50,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Peace%20Lily.jpg",
    "category": "Indoor",
    "discount": 10,
    "recommend_for_you": true
  },
  {
    "plant_id": "p005",
    "name": "Cactus",
    "description":
        "Cactus plants are perfect for busy people, storing water in their stems to survive dry conditions. Their unique shapes make them great decorative plants.",
    "price": 6.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Cactus.jpg",
    "category": "Home Decor",
    "discount": 0,
    "recommend_for_you": false
  },
  {
    "plant_id": "p006",
    "name": "Bamboo Palm",
    "description":
        "Bamboo Palm is an elegant indoor plant that purifies air. Prefers indirect sunlight and moderate watering, perfect for living rooms and offices.",
    "price": 16.75,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Bamboo%20Palm.jpg",
    "category": "Indoor",
    "discount": 12,
    "recommend_for_you": true
  },
  {
    "plant_id": "p007",
    "name": "Fiddle Leaf Fig",
    "description":
        "Fiddle Leaf Fig has large, glossy leaves that create a bold decorative statement. Thrives in bright indirect light and adds a modern touch indoors.",
    "price": 22.00,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Fiddle%20Leaf%20Fig.jpg",
    "category": "Home Decor",
    "discount": 20,
    "recommend_for_you": false
  },
  {
    "plant_id": "p008",
    "name": "Spider Plant",
    "description":
        "Spider Plant is easy to grow, adapts to various light conditions, and improves indoor air quality with its long green leaves and white stripes.",
    "price": 9.50,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Spider%20Plant.jpg",
    "category": "Office",
    "discount": 8,
    "recommend_for_you": true
  },
  {
    "plant_id": "p009",
    "name": "Rubber Plant",
    "description":
        "Rubber Plant is known for its thick, shiny leaves. Prefers bright indirect light and adds a bold green presence to home interiors.",
    "price": 19.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Rubber%20Plant.jpg",
    "category": "Indoor",
    "discount": 10,
    "recommend_for_you": false
  },
  {
    "plant_id": "p010",
    "name": "ZZ Plant",
    "description":
        "ZZ Plant tolerates low light and drought conditions. Its waxy leaves store water efficiently, making it ideal for offices and beginners.",
    "price": 13.25,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/ZZ%20Plant.jpg",
    "category": "Office",
    "discount": 5,
    "recommend_for_you": true
  },
  {
    "plant_id": "p011",
    "name": "Lavender",
    "description":
        "Lavender is a fragrant outdoor plant with purple flowers and a calming aroma. Requires full sun and is often used for relaxation and decoration.",
    "price": 11.00,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Lavender.jpg",
    "category": "Garden",
    "discount": 10,
    "recommend_for_you": false
  },
  {
    "plant_id": "p012",
    "name": "Rose Plant",
    "description":
        "Rose plants are classic outdoor flowering plants admired for their beauty and fragrance. Require sunlight and care to produce stunning blooms.",
    "price": 17.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Rose%20Plant.jpg",
    "category": "Garden",
    "discount": 15,
    "recommend_for_you": true
  },
  {
    "plant_id": "p013",
    "name": "Jade Plant",
    "description":
        "Jade Plant is a succulent symbolizing prosperity. Requires minimal watering and bright light, making it easy to maintain indoors.",
    "price": 10.50,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/jade%20Plant.jpg",
    "category": "Indoor",
    "discount": 5,
    "recommend_for_you": true
  },
  {
    "plant_id": "p014",
    "name": "Fern",
    "description":
        "Ferns are lush green plants that thrive in humid, shaded areas. Perfect for bathrooms, balconies, and shaded outdoor spots.",
    "price": 9.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Fern.jpg",
    "category": "Balcony",
    "discount": 0,
    "recommend_for_you": false
  },
  {
    "plant_id": "p015",
    "name": "Orchid",
    "description":
        "Orchids are elegant flowering plants with long-lasting blooms. Require indirect light and careful watering, ideal for premium indoor decoration.",
    "price": 24.50,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Orchid.jpg",
    "category": "Home Decor",
    "discount": 20,
    "recommend_for_you": true
  },
  {
    "plant_id": "p016",
    "name": "Mint",
    "description":
        "Mint is a fast-growing herb known for its fresh aroma and culinary uses. Prefers sunlight and is perfect for kitchen gardens and balconies.",
    "price": 5.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Mint.jpg",
    "category": "Balcony",
    "discount": 0,
    "recommend_for_you": false
  },
  {
    "plant_id": "p017",
    "name": "Basil",
    "description":
        "Basil is a popular herb used in cooking and home gardens. Prefers warm weather and sunlight, offering fresh leaves for culinary purposes.",
    "price": 6.50,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Basil.jpg",
    "category": "Balcony",
    "discount": 5,
    "recommend_for_you": true
  },
  {
    "plant_id": "p018",
    "name": "Sunflower",
    "description":
        "Sunflower is a bright and cheerful outdoor plant with large yellow blooms. Grows best in full sunlight and symbolizes positivity.",
    "price": 7.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Sunflower.jpg",
    "category": "Garden",
    "discount": 0,
    "recommend_for_you": false
  },
  {
    "plant_id": "p019",
    "name": "Money Plant",
    "description":
        "Money Plant is believed to bring prosperity and positive energy. Easy to grow indoors with minimal care required.",
    "price": 9.25,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Money%20Plant.jpg",
    "category": "Indoor",
    "discount": 10,
    "recommend_for_you": true
  },
  {
    "plant_id": "p020",
    "name": "Areca Palm",
    "description":
        "Areca Palm is a graceful indoor plant that purifies air and adds a tropical vibe. Thrives in bright indirect light with regular watering.",
    "price": 20.00,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Areca%20Palm.jpg",
    "category": "Indoor",
    "discount": 15,
    "recommend_for_you": false
  },
  {
    "plant_id": "p021",
    "name": "Tulip",
    "description":
        "Tulips are vibrant spring flowers known for their cup-shaped blooms and wide range of colors. Best grown outdoors with good sunlight.",
    "price": 8.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/tulip.jpg",
    "category": "Flower",
    "discount": 5,
    "recommend_for_you": true
  },
  {
    "plant_id": "p022",
    "name": "Daisy",
    "description":
        "Daisy flowers are simple and cheerful with white petals and yellow centers. Easy to grow and great for gardens.",
    "price": 6.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/daisy.jpg",
    "category": "Flower",
    "discount": 0,
    "recommend_for_you": false
  },
  {
    "plant_id": "p023",
    "name": "Hibiscus",
    "description":
        "Hibiscus plants produce large, colorful blooms and thrive in sunny outdoor environments.",
    "price": 14.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Hibiscus%20pot.jpg",
    "category": "Flower",
    "discount": 10,
    "recommend_for_you": true
  },
  {
    "plant_id": "p024",
    "name": "Geranium",
    "description":
        "Geraniums are popular flowering plants with bright blooms, perfect for balconies and window boxes.",
    "price": 7.50,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Geranium.jpg",
    "category": "Flower",
    "discount": 0,
    "recommend_for_you": false
  },
  {
    "plant_id": "p025",
    "name": "Petunia",
    "description":
        "Petunias are colorful flowering plants ideal for hanging baskets and garden borders.",
    "price": 6.25,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Petunia%20pot.jpg",
    "category": "Flower",
    "discount": 5,
    "recommend_for_you": true
  },
  {
    "plant_id": "p026",
    "name": "Marigold",
    "description":
        "Marigolds are bright orange and yellow flowers known for pest-repelling properties.",
    "price": 5.50,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Marigold.jpg",
    "category": "Flower",
    "discount": 0,
    "recommend_for_you": false
  },
  {
    "plant_id": "p027",
    "name": "Begonia",
    "description":
        "Begonias have attractive foliage and delicate flowers, suitable for indoor and shaded outdoor areas.",
    "price": 9.75,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Begonia.jpg",
    "category": "Flower",
    "discount": 10,
    "recommend_for_you": true
  },
  {
    "plant_id": "p028",
    "name": "Anthurium",
    "description":
        "Anthurium plants feature glossy leaves and heart-shaped flowers, ideal for elegant indoor décor.",
    "price": 19.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Anthurium.jpg",
    "category": "Flower",
    "discount": 15,
    "recommend_for_you": true
  },
  {
    "plant_id": "p029",
    "name": "Chrysanthemum",
    "description":
        "Chrysanthemums are bushy flowering plants with long-lasting blooms, perfect for gardens.",
    "price": 8.75,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Chrysanthemum.jpg",
    "category": "Flower",
    "discount": 5,
    "recommend_for_you": false
  },
  {
    "plant_id": "p030",
    "name": "Lotus",
    "description":
        "Lotus is an aquatic flowering plant symbolizing purity and peace, commonly grown in ponds.",
    "price": 15.99,
    "image":
        "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/lotus.jpg",
    "category": "Flower",
    "discount": 10,
    "recommend_for_you": true
  },
  {
    "plant_id": "p031",
    "name": "Romduol",
    "description":
        "Romduol is Cambodia’s national flower, known for its fragrant yellow blooms and cultural significance.",
    "price": 18.50,
    "image": "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/romdoul.jpg",
    "category": "Flower",
    "discount": 10,
    "recommend_for_you": true
  },
  {
    "plant_id": "p032",
    "name": "Jasmine",
    "description":
        "Jasmine flowers are small, white, and fragrant, commonly used in religious offerings in Cambodia.",
    "price": 7.99,
    "image": "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Jasmine.jpg",
    "category": "Flower",
    "discount": 0,
    "recommend_for_you": true
  },
  {
    "plant_id": "p033",
    "name": "Plumeria",
    "description":
        "Plumeria, also known as Champa flower, is sacred and widely planted around temples.",
    "price": 15.75,
    "image": "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/Plumeria.jpg",
    "category": "Garden",
    "discount": 10,
    "recommend_for_you": true
  },
  {
    "plant_id": "p034",
    "name": "Water Lily",
    "description":
        "Water Lily is an aquatic flowering plant often seen in Cambodian ponds and lakes.",
    "price": 13.50,
    "image": "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/water%20lily.jpg",
    "category": "Garden",
    "discount": 5,
    "recommend_for_you": false
  },
  {
    "plant_id": "p035",
    "name": "Ixora",
    "description":
        "Ixora has clustered bright flowers and is commonly planted in Cambodian gardens.",
    "price": 9.50,
    "image": "https://jjosmcpndscluomfdrts.supabase.co/storage/v1/object/public/image_plant/ixora%20potted.jpg",
    "category": "Flower",
    "discount": 0,
    "recommend_for_you": false
  },
  
];
