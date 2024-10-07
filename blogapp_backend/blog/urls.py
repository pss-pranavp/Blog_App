from django.urls import path
from .views import BlogPostListCreate, BlogPostRetrieveUpdateDestroy, BlogPostListAPIView, RegisterView, LoginView

urlpatterns = [
    path('posts/', BlogPostListCreate.as_view(), name='post_list_create'),
    path('posts/<int:pk>/', BlogPostRetrieveUpdateDestroy.as_view(), name='post_detail'),
    path('blog/blogpost/', BlogPostListAPIView.as_view(), name='api_blogpost_list'),
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
]
