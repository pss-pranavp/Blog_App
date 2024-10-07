from django.db import models
#from django.contrib.auth.models import AbstractUser

class BlogPost(models.Model):
    title = models.CharField(max_length=255)
    author = models.CharField(max_length=255)
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

class Users(models.Model):
    username = models.CharField(max_length=100)
    email = models.EmailField()
    password = models.CharField(max_length=100)

    def __str__(self):
        return self.username

# class Users(models.Model):
#     username = models.CharField(max_length=50, unique=True)
#     email = models.EmailField(max_length=100, unique=True)
#     password = models.CharField(max_length=255)

#     def __str__(self):
#         return self.username


# class Users(AbstractUser):
#     username = models.CharField(max_length=50, unique=True)
#     email = models.EmailField(max_length=100, unique=True)
#     password = models.CharField(max_length=255)

#     # Adding related_name to avoid conflicts
#     groups = models.ManyToManyField(
#         'auth.Group',
#         related_name='custom_user_set',  # Custom related_name
#         blank=True,
#         help_text='The groups this user belongs to.',
#         verbose_name='groups'
#     )
#     user_permissions = models.ManyToManyField(
#         'auth.Permission',
#         related_name='custom_user_set_permissions',  # Custom related_name
#         blank=True,
#         help_text='Specific permissions for this user.',
#         verbose_name='user permissions'
#     )

#     def __str__(self):
#         return self.username
