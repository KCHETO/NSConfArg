from core.model.sports import Sport
from mongoengine import connect

kitesurf_image = [
    "http://images.freeimages.com/images/thumbs/c55/kitesurf-5-1376750.jpg",
    "http://images.freeimages.com/images/thumbs/759/kitesurfer-1253805.jpg",
    "http://images.freeimages.com/images/thumbs/62c/kitesurfer-sunset-1490014.jpg",
    "http://images.freeimages.com/images/thumbs/66f/kitesurf-2-1441876.jpg",
    "http://images.freeimages.com/images/thumbs/fbf/kitesurfing-1-1540708.jpg",
    "http://images.freeimages.com/images/thumbs/4ff/kitesurfing-5-1442467.jpg",
    "http://images.freeimages.com/images/thumbs/b6e/kitesurf-on-the-ice-1548019.jpg",
    "http://images.freeimages.com/images/thumbs/968/kitesurf-3-1377099.jpg",
    "http://images.freeimages.com/images/thumbs/566/kite-1422717.jpg",
    "http://images.freeimages.com/images/thumbs/3ac/kitesurfing-2-1542010.jpg",
    "http://images.freeimages.com/images/thumbs/6b4/kitesurfing-3-1542004.jpg",
    "http://images.freeimages.com/images/thumbs/a68/kitesurfing-1-1442503.jpg",
    "http://images.freeimages.com/images/thumbs/4ea/kitesurfing-3-1442473.jpg",
    "http://images.freeimages.com/images/thumbs/8a5/kitesurf-2-1376752.jpg",
    "http://images.freeimages.com/images/thumbs/fa3/kitesurf-2-1376747.jpg",
    "http://images.freeimages.com/images/thumbs/494/kitesurf-2-1376855.jpg",
    "http://images.freeimages.com/images/thumbs/e2b/kitesurf-3-1376848.jpg",
    "http://images.freeimages.com/images/thumbs/c4a/kitesurf-4-1376840.jpg",
    "http://images.freeimages.com/images/thumbs/c09/kiteboarder-1253808.jpg",
    "http://images.freeimages.com/images/thumbs/b99/kitesurf-1-1441882.jpg",
    "http://images.freeimages.com/images/thumbs/8ff/kitesurfing-2-1442474.jpg",
    "http://images.freeimages.com/images/thumbs/478/kitesurfing-4-1442470.jpg",
    "http://images.freeimages.com/images/thumbs/3d6/kitesurfing-4-1542006.jpg",
    "http://images.freeimages.com/images/thumbs/07e/kitesurf-2-1377107.jpg",
    "http://images.freeimages.com/images/thumbs/5b5/kite-surfing-1256571.jpg",
    "http://images.freeimages.com/images/thumbs/f4e/follow-your-kite-1436481.jpg",
    "http://images.freeimages.com/images/thumbs/325/follow-your-kite-1436476.jpg",
    "http://images.freeimages.com/images/thumbs/9fe/kite-gotland-1559206.jpg",
    "http://images.freeimages.com/images/thumbs/7cd/kite-1422722.jpg",
    "http://images.freeimages.com/images/thumbs/718/kitesurfing-boracay-1437423.jpg"
]

ski_images = [
    "http://images.freeimages.com/images/thumbs/937/skiing-1478700.jpg",
    "http://images.freeimages.com/images/thumbs/aba/skiing-in-the-alps-1368053.jpg",
    "http://images.freeimages.com/images/thumbs/bfb/skiing-in-the-alps-1368044.jpg",
    "http://images.freeimages.com/images/thumbs/ece/skiing-in-the-alps-1368050.jpg",
    "http://images.freeimages.com/images/thumbs/d78/skiing-1371473.jpg",
    "http://images.freeimages.com/images/thumbs/c43/skies-1533329.jpg",
    "http://images.freeimages.com/images/thumbs/600/ski-2-1531222.jpg",
    "http://images.freeimages.com/images/thumbs/95c/ski-panorama-1489987.jpg",
    "http://images.freeimages.com/images/thumbs/33d/skiing-kangaroo-1444773.jpg",
    "http://images.freeimages.com/images/thumbs/788/ski-utah-1401792.jpg",
    "http://images.freeimages.com/images/thumbs/464/ski-utah-1401797.jpg",
    "http://images.freeimages.com/images/thumbs/0fa/ski-lift-1434757.jpg",
    "http://images.freeimages.com/images/thumbs/ba1/skis-1474938.jpg",
    "http://images.freeimages.com/images/thumbs/401/skiing-in-austria-1397420.jpg",
    "http://images.freeimages.com/images/thumbs/9b6/ski-trip-1403800.jpg",
    "http://images.freeimages.com/images/thumbs/f21/heavenly-skies-1386721.jpg",
    "http://images.freeimages.com/images/thumbs/725/ski-1434043.jpg",
    "http://images.freeimages.com/images/thumbs/6b6/oakley-ski-goggles-1438364.jpg",
    "http://images.freeimages.com/images/thumbs/d9f/skiing-1389059.jpg",
    "http://images.freeimages.com/images/thumbs/5dc/skiing-1-1543149.jpg",
    "http://images.freeimages.com/images/thumbs/bbe/gone-skiing-1424437.jpg",
    "http://images.freeimages.com/images/thumbs/127/skiing-in-the-alps-1368065.jpg",
    "http://images.freeimages.com/images/thumbs/fb7/seagull-1537961.jpg",
    "http://images.freeimages.com/images/thumbs/088/clouds-by-dm-1539325.jpg",
    "http://images.freeimages.com/images/thumbs/bb0/ischgl-slope-1395343.jpg",
    "http://images.freeimages.com/images/thumbs/d61/sky-1401882.jpg",
    "http://images.freeimages.com/images/thumbs/ac7/sky-1401862.jpg",
    "http://images.freeimages.com/images/thumbs/fbf/first-time-on-skis-1439440.jpg",
    "http://images.freeimages.com/images/thumbs/51f/nature-1-1519300.jpg",
    "http://images.freeimages.com/images/thumbs/029/no-description-1402330.jpg"
]


def insert_ski_images():
    for x in range(1, len(ski_images)):
        name = "Ski Image #" + str(x)
        image = ski_images[x]
        ski = Sport(name=name, image=image, category="Ski")
        ski.save()


def insert_kite_images():
    for x in range(1, len(kitesurf_image)):
        name = "Kitesurf Image #" + str(x)
        image = kitesurf_image[x]
        kite = Sport(name=name, image=image, category="Kite")
        kite.save()


def insert_sports():
    insert_kite_images()
    insert_ski_images()

if __name__ == "__main__":
    connect('nsconfarg')
    insert_sports()
